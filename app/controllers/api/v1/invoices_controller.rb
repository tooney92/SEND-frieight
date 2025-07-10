class Api::V1::InvoicesController < ApplicationController
  def overdue
    result = Invoices::OverdueQuery.new(
      page: params[:page],
      per_page: params[:per_page]
    ).call

    render json: result
  end
end
