class RefundRequest < ApplicationRecord
  self.table_name = "remboursement"


  # NOTE:
  # The legacy schema doesn’t define a DB-level foreign key between
  # `remboursement.numero_bl` (renamed here to `bill_of_lading_number`)
  # and `bl.numero_bl` (now `number`).
  #
  # I decided not to add a database constraint here because:
  # - Rails handles the association cleanly using `foreign_key` and `primary_key`
  # - This is enough for the querying and business logic I need
  # - The assessment doesn’t explicitly require enforcing this at the DB level


  belongs_to :bill_of_lading,
             class_name: "BillOfLading",
             foreign_key: :bill_of_lading_number,
             primary_key: :number

  # Optional validations
  validates :bill_of_lading_number, presence: true
  validates :amount_requested, presence: true, numericality: { greater_than: 0 }

  # I could enum for status if the values are known. This would keep this inline with rails conventions.
  # One strategy to migrate exisiting columns is to create a second column called status_2 and do the mappings
  # then delete the original status column. then rename status_2 to status. N/B relying on strong migrations.

  # enum status: { pending: "pending", approved: "approved", rejected: "rejected" }
end
