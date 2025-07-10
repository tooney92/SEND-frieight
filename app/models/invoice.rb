class Invoice < ApplicationRecord
  self.table_name = "facture"

  # NOTE:
  # Considered adding a format validation (e.g., /^INV-\d+$/) for `reference` if invoice codes follow a specific structure.
  # Left flexible for now since the legacy schema does not indicate a strict pattern.
  # Keeping `client_code` and `client_name` as-is for now. These could be normalized
  # into a separate `Customer` association if needed later.

  # Associations
  belongs_to :bill_of_lading, foreign_key: :bill_of_lading_number, primary_key: :number, class_name: "BillOfLading", optional: false

  # Validations (optional, based on schema)
  validates :reference, presence: true, uniqueness: true
  validates :amount, presence: true
  validates :bill_of_lading_number, presence: true
  validates :amount, numericality: { greater_than: 0 }
  validates :invoice_date, presence: true
end

