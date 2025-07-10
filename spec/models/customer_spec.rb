require "rails_helper"

RSpec.describe Customer, type: :model do
  subject { build(:customer) }  # Ensures other validations don’t interfere with inclusion test

  describe "associations" do
    it { should have_many(:bill_of_ladings).with_foreign_key(:customer_id) }
  end

  describe "validations" do
    it {
      should define_enum_for(:status).with_values(
        active: "active",
        inactive: "inactive"
      ).backed_by_column_of_type(:string)
    }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:code) }
    it { should allow_value(true, false).for(:pays_deposit) }
  end
end
