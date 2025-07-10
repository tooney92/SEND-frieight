# spec/requests/api/v1/invoices_spec.rb
require 'rails_helper'

RSpec.describe "Api::V1::Invoices", type: :request do
  describe "GET /api/v1/invoices" do
    let!(:open_invoices) { create_list(:invoice, 3, status: "open") }
    let!(:closed_invoices) { create_list(:invoice, 2, status: "closed") }

    it "returns only open invoices" do
      get "/api/v1/invoices/overdue", headers: { "ACCEPT" => "application/json" }

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)

      expect(json["data"].size).to eq(open_invoices.size)
      expect(json["data"].all? { |inv| inv["status"] == "open" }).to be true
    end

    it "returns paginated results" do
      get "/api/v1/invoices/overdue", params: { page: 1, per_page: 2 }, headers: { "ACCEPT" => "application/json" }

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)

      expect(json["pagination"]["current_page"]).to eq(1)
      expect(json["pagination"]["total_count"]).to eq(open_invoices.size)
    end
  end
end
