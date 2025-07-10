class BillOfLading < ApplicationRecord
  self.table_name = "bl"

  belongs_to :customer, foreign_key: :customer_id, class_name: "Customer"

  has_many :invoices,
           class_name: "Invoice",
           foreign_key: :bill_of_lading_number,
           primary_key: :number

  has_one :open_invoice,
          -> { where(status: "open") },
          class_name: "Invoice",
          foreign_key: :bill_of_lading_number,
          primary_key: :number

  has_many :refund_requests,
           class_name: "RefundRequest",
           foreign_key: :bill_of_lading_number,
           primary_key: :number

  validates :number, presence: true, uniqueness: { case_sensitive: false }

  # Scope: BLs that became overdue on a given date
  scope :overdue_as_of, ->(date) {
    where("arrival_date + INTERVAL freetime DAY <= ?", date)
  }


  # Total container count (used for invoice calculation)
  def container_count
    %i[
      n20_sec
      n40_sec
      n20_frigo
      n40_frigo
      n20_special
      n40_special
    ].sum { |field| self[field].to_i }
  end
end
