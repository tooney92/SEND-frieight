class BillOfLading < ApplicationRecord
  self.table_name = "bl"

  belongs_to :customer, foreign_key: :customer_id, class_name: "Customer"

  has_many :invoices,
           class_name: "Invoice",
           foreign_key: :bill_of_lading_number,
           primary_key: :number

  has_many :refund_requests,
           class_name: "RefundRequest",
           foreign_key: :bill_of_lading_number,
           primary_key: :number

  validates :number, presence: true, uniqueness: { case_sensitive: false }

  # Scope: find BLs overdue as of a specific date
  scope :overdue_as_of, ->(date) {
    where("DATE(arrival_date + INTERVAL freetime DAY) = ?", date)
  }

  # Total container count (for invoice generation)
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
