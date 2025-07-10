# app/services/demurrage/invoice_generator.rb
module Demurrage
  class InvoiceGenerator < ApplicationService
    DAILY_RATE = 80
    STATUS_OPEN = "open"

    def initialize(date = Date.today)
      @date = date
    end

    def call
      BillOfLading
        .overdue_as_of(@date)
        .includes(:invoices, :customer)  # Avoid N+1 queries
        .find_each do |bl|

        next if bl.invoices.any? { |inv| inv.status == STATUS_OPEN }
        next if bl.container_count.zero?

        create_invoice_for(bl)
      end
    end

    private

    def create_invoice_for(bill_of_lading)
      overdue_days = (@date.to_date - (bill_of_lading.arrival_date + bill_of_lading.freetime.days).to_date).to_i
      return unless overdue_days.positive?

      container_count = bill_of_lading.container_count
      return if container_count.zero?

      amount = container_count * overdue_days * DAILY_RATE

      Invoice.create!(
        reference: generate_reference,
        bill_of_lading_number: bill_of_lading.number,
        client_code: bill_of_lading.customer.code,
        client_name: bill_of_lading.customer.name,
        amount: amount,
        original_amount: amount,
        devise: "USD",
        status: STATUS_OPEN,
        invoice_date: @date,
        id_utilisateur: 1
      )
    end

    def generate_reference
      "INV#{SecureRandom.hex(2).upcase}" # "INV" + 4 hex chars = 7 total
    end

  end
end
