class Api::V1::InvoicesController < ApplicationController

  def create
    invoice = Invoice.new(invoice_params)
    if invoice.save
      render json: invoice, status: :created
    else
      render json: { errors: invoice.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def overdue
    result = Invoices::OverdueQuery.new(
      page: params[:page],
      per_page: params[:per_page]
    ).call

    render json: result
  end

  private

  def invoice_params
    params.require(:invoice).permit(
      :reference,
      :bill_of_lading_number,
      :client_code,
      :client_name,
      :amount,
      :original_amount,
      :devise,
      :status,
      :invoice_date,
      :id_utilisateur
    )
  end
end
