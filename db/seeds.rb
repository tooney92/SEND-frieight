# frozen_string_literal: true


SEEDFILES_DIR = Rails.root.join("db/seed_files").to_s.freeze

def main
  puts "Running db:seed in env: #{Rails.env}"
  run_seed_files
end

def run_seed_files
  seeds_to_run.each do |path|
    raise StandardError, "Seedfile #{path} not found" unless File.exist? path

    puts "Running #{path}"

    # load and execute the file
    require path
  end
end

# Run either: all seeds, or only those provided on CLI
def seeds_to_run
  if args_seeders.count.positive?
    args_seeders
  else
    (env_seeders + common_seeders).sort
  end
end

# Get all seedfiles passed in as CLI args
def args_seeders
  return [] if ENV["seeds"].nil?

  inputs = ENV["seeds"].split(",")

  inputs.map do |str|
    is_relative = str.split("/").length > 1

    path = if is_relative
             str
           else
             _resolve_seedfile_path str
           end

    path
  end
end

# Get all seedilfes in a subdir named after the current RAILS_ENV
def env_seeders
  in_subdir Rails.env
end

# Get all seedfiles in the common subdir
def common_seeders
  in_subdir "common"
end

# List all the non-hidden .rb files in a subdir of SEEDFILES_DIR
def in_subdir(input)
  dir = Pathname.new(SEEDFILES_DIR) + input

  if Dir.exist?(dir)
    Dir
      .entries(dir)
      .select { |fname| fname[0] != "." && fname.match(/\.rb$/) }
      .sort
      .map do |fname|
      dir + fname
    end
  else
    # TODO: return empty input or raise exception?
    []
  end
end

# For a filename or partial path to a seeder as input, resolve the full path to the file if it exists
def _resolve_seedfile_path(str)
  (common_seeders + env_seeders).find { |path| path.to_s.include?(str.to_s) }
end

# actually execute this file
main

