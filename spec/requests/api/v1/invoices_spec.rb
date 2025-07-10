require 'rails_helper'

RSpec.describe "Api::V1::Invoices", type: :request do
  describe "GET /api/v1/invoices/overdue" do
    let!(:open_invoices) { create_list(:invoice, 3, status: "open") }
    let!(:closed_invoices) { create_list(:invoice, 2, status: "closed") }

    context "without pagination params" do
      it "returns only open invoices" do
        get "/api/v1/invoices/overdue", headers: { "ACCEPT" => "application/json" }

        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body)
        expect(json["data"].size).to eq(open_invoices.size)
        expect(json["data"].pluck("status").uniq).to eq(["open"])
      end
    end

    context "with pagination params" do
      it "returns paginated open invoices" do
        get "/api/v1/invoices/overdue", params: { page: 1, per_page: 2 }, headers: { "ACCEPT" => "application/json" }

        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body)

        expect(json["pagination"]["current_page"]).to eq(1)
        expect(json["pagination"]["total_count"]).to eq(open_invoices.size)
        expect(json["data"].size).to eq(2)
      end
    end
  end

  describe "POST /api/v1/invoices" do
    let!(:bl) { create(:bill_of_lading) }

    let(:valid_params) do
      {
        invoice: {
          reference: "INV-123456",
          bill_of_lading_number: bl.number,
          client_code: bl.customer.code,
          client_name: bl.customer.name,
          amount: 1000,
          original_amount: 1000,
          devise: "USD",
          status: "open",
          invoice_date: Date.today,
          id_utilisateur: 1
        }
      }
    end

    it "creates a new invoice" do
      expect {
        post "/api/v1/invoices", params: valid_params, headers: { "ACCEPT" => "application/json" }
      }.to change(Invoice, :count).by(1)

      expect(response).to have_http_status(:created)
      json = JSON.parse(response.body)
      expect(json["reference"]).to eq("INV-123456")
    end

    it "returns error when required fields are missing" do
      post "/api/v1/invoices", params: { invoice: { amount: nil } }, headers: { "ACCEPT" => "application/json" }

      expect(response).to have_http_status(:unprocessable_entity)
      json = JSON.parse(response.body)
      expect(json["errors"]).to be_present
    end
  end
end
