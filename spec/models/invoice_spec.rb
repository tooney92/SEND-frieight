# spec/models/invoice_spec.rb
require "rails_helper"

RSpec.describe Invoice, type: :model do
  let(:bill_of_lading) { create(:bill_of_lading) }
  subject { create(:invoice, bill_of_lading_number: bill_of_lading.number) }

  describe "associations" do
    it "is linked to a bill of lading via bill_of_lading_number" do
      expect(subject.bill_of_lading_number).to eq(bill_of_lading.number)
    end
  end

  describe "validations" do
    it { should validate_presence_of(:reference) }

    it "validates uniqueness of reference" do
      create(:invoice, reference: "UNIQUE_REF", bill_of_lading_number: bill_of_lading.number)
      expect {
        create(:invoice, reference: "UNIQUE_REF", bill_of_lading_number: bill_of_lading.number)
      }.to raise_error(ActiveRecord::RecordInvalid, /Reference has already been taken/i)
    end
  end
end
