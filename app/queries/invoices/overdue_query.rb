# app/queries/invoices/overdue_query.rb
module Invoices
  class OverdueQuery
    def initialize(page:, per_page:)
      @page = page || 1
      @per_page = per_page || 20
    end

    def call
      invoices = Invoice
                   .includes(bill_of_lading: :customer)
                   .where(status: "open")
                   .order(invoice_date: :desc)
                   .page(@page)
                   .per(@per_page)

      {
        data: invoices.map { |inv| serialize(inv) },
        pagination: {
          current_page: invoices.current_page,
          total_pages: invoices.total_pages,
          total_count: invoices.total_count
        }
      }
    end

    private

    def serialize(invoice)
      {
        id: invoice.id,
        reference: invoice.reference,
        client_name: invoice.client_name,
        amount: invoice.amount,
        devise: invoice.devise,
        status: invoice.status,
        invoice_date: invoice.invoice_date,
        bill_of_lading_number: invoice.bill_of_lading_number,
        customer: {
          code: invoice.bill_of_lading.customer.code,
          name: invoice.bill_of_lading.customer.name
        }
      }
    end
  end
end
