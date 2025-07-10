class RenameFactureColumns < ActiveRecord::Migration[7.1]
  def change
    # Translated from French to English
    rename_column :facture, :montant_facture, :amount             # "montant_facture" → "amount"
    rename_column :facture, :montant_orig, :original_amount       # "montant_orig" → "original_amount"
    rename_column :facture, :statut, :status                      # "statut" → "status"
    rename_column :facture, :date_facture, :invoice_date          # "date_facture" → "invoice_date"

    # Simplified column names
    rename_column :facture, :code_client, :client_code            # "code_client" → "client_code"
    rename_column :facture, :nom_client, :client_name             # "nom_client" → "client_name"
  end
end
