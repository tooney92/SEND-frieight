class FixBillOfLadingNumberColumnTypeAndAddFk < ActiveRecord::Migration[7.1]
  def change
    # Step 1: Convert to CHAR(9) and latin1 (matches `bl.number`)
    execute <<~SQL
      ALTER TABLE facture
      MODIFY bill_of_lading_number CHAR(9) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL;
    SQL

    # Step 2: Add FK from facture.bill_of_lading_number → bl.number
    add_foreign_key :facture, :bl, column: :bill_of_lading_number, primary_key: :number
  end
end
