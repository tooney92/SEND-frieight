require "rails_helper"

RSpec.describe BillOfLading, type: :model do
  subject { create(:bill_of_lading) } # <-- Persisted record for uniqueness matcher

  describe "associations" do
    it { should belong_to(:customer).with_foreign_key(:customer_id) }
    it { should have_many(:invoices).with_foreign_key(:bill_of_lading_number).with_primary_key(:number) }
    it { should have_many(:refund_requests).with_foreign_key(:bill_of_lading_number).with_primary_key(:number) }
  end

  describe "validations" do
    it { should validate_presence_of(:number) }
    it { should validate_uniqueness_of(:number).case_insensitive }
  end

  describe "#container_count" do
    it "sums all container count fields" do
      bl = build(:bill_of_lading, n20_sec: 1, n40_sec: 2, n20_frigo: 3, n40_frigo: 4, n20_special: 5, n40_special: 6)
      expect(bl.container_count).to eq(21)
    end
  end
end
