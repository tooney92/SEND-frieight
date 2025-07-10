require 'rails_helper'

RSpec.describe Demurrage::InvoiceGenerationJob, type: :job do
  it "calls the Demurrage::InvoiceGenerator with today's date" do
    expect(Demurrage::InvoiceGenerator).to receive(:call).with(Date.today)
    described_class.perform_now
  end
end
