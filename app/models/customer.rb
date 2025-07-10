class Customer < ApplicationRecord
  self.table_name = "client"

  # Associations
  has_many :bill_of_ladings, foreign_key: :customer_id

  # Validations
  validates :name, presence: true
  validates :code, presence: true, uniqueness: true

  # Optional: Enforce boolean fields explicitly
  validates :pays_deposit, inclusion: { in: [true, false] }
  validates :priority, inclusion: { in: [true, false] }, allow_nil: true

  # Scopes
  scope :active, -> { where.not(valid_until: nil).where('valid_until > ?', Time.current) }
  scope :prioritized, -> { where(priority: true) }
end
