class RenameBlColumns < ActiveRecord::Migration[7.1]
  def change
    # Translated from French to English
    rename_column :bl, :numero_bl, :number                   # "numero_bl" → "number"
    rename_column :bl, :id_client, :customer_id              # FK: "id_client" → "customer_id"
    rename_column :bl, :statut, :status                      # "statut" → "status"
    rename_column :bl, :exempte, :exempt                     # "exempte" → "exempt"
    rename_column :bl, :date_validite, :valid_until          # "date_validite" → "valid_until"

    # Container counts – simplified for Rails
    rename_column :bl, :nbre_20pieds_sec,     :n20_sec       # 20ft standard
    rename_column :bl, :nbre_40pieds_sec,     :n40_sec       # 40ft standard
    rename_column :bl, :nbre_20pieds_frigo,   :n20_frigo     # 20ft refrigerated
    rename_column :bl, :nbre_40pieds_frigo,   :n40_frigo     # 40ft refrigerated
    rename_column :bl, :nbre_20pieds_special, :n20_special   # 20ft special
    rename_column :bl, :nbre_40pieds_special, :n40_special   # 40ft special
  end
end
