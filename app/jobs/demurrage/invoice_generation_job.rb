module Demurrage
  class InvoiceGenerationJob < ApplicationJob
    queue_as :default

    def perform(date = Date.today)
      InvoiceGenerator.call(date)
    end
  end
end
