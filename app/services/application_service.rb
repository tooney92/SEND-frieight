class ApplicationService
  def self.call(*args, &block)
    #noinspection RubyArgCount
    new(*args, &block).call
  end

end