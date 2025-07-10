class RenameRemboursementColumns < ActiveRecord::Migration[7.1]
  def change
    rename_column :remboursement, :numero_bl, :bill_of_lading_number       # FK to `bl.number`
    rename_column :remboursement, :montant_demande, :amount_requested      # Refund amount
    rename_column :remboursement, :statut, :status                          # Status of request
  end
end
