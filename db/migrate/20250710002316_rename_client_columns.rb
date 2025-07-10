class RenameClientColumns < ActiveRecord::Migration[7.1]
  def change
    # Translated from French to English
    rename_column :client, :nom, :name                         # "nom" → "name"
    rename_column :client, :nom_groupe, :group_name            # "nom_groupe" → "group_name"
    rename_column :client, :paie_caution, :pays_deposit        # "paie_caution" → "pays_deposit"
    rename_column :client, :statut, :status                    # "statut" → "status"
    rename_column :client, :prioritaire, :priority             # "prioritaire" → "priority"
    rename_column :client, :date_validite, :valid_until        # "date_validite" → "valid_until"

    # Simplified for clarity (not translation)
    rename_column :client, :code_client, :code                 # "code_client" → "code"
  end
end
