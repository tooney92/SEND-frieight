require "rails_helper"

RSpec.describe Demurrage::InvoiceGenerator, type: :service do
  describe ".call" do
    let(:date) { Date.today }

    context "when a BL becomes overdue today" do
      it "creates an invoice with the correct amount" do
        bl = create(:bill_of_lading, arrival_date: date - 10, freetime: 5)

        expect {
          described_class.call(date)
        }.to change(Invoice, :count).by(1)

        invoice = Invoice.last
        overdue_days = (date.to_date - (bl.arrival_date + bl.freetime.days).to_date).to_i
        expected_amount = bl.container_count * overdue_days * 80

        expect(invoice.bill_of_lading_number).to eq(bl.number)
        expect(invoice.amount).to eq(expected_amount)
        expect(invoice.status).to eq("open")
      end
    end

    context "when BL already has an open invoice" do
      it "skips invoice creation" do
        bl = create(:bill_of_lading, arrival_date: date - 10, freetime: 5)
        create(:invoice, bill_of_lading_number: bl.number, status: "open")

        expect {
          described_class.call(date)
        }.not_to change(Invoice, :count)
      end
    end

    context "when container count is zero" do
      it "skips invoice creation" do
        bl = create(:bill_of_lading, arrival_date: date - 10, freetime: 5,
                    n20_sec: 0, n40_sec: 0, n20_frigo: 0,
                    n40_frigo: 0, n20_special: 0, n40_special: 0)

        expect(bl.container_count).to eq(0)

        expect {
          described_class.call(date)
        }.not_to change(Invoice, :count)
      end
    end
  end
end
