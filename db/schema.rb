# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2025_07_10_021331) do
  create_table "bl", primary_key: "id_bl", id: :integer, charset: "latin1", force: :cascade do |t|
    t.integer "id_upload"
    t.datetime "date_upload", precision: nil
    t.string "number", limit: 9, null: false
    t.integer "customer_id"
    t.string "consignee_code", limit: 20
    t.string "consignee_name", limit: 60
    t.string "notified_code", limit: 20
    t.string "notified_name", limit: 60
    t.string "vessel_name", limit: 30
    t.string "vessel_voyage", limit: 10
    t.datetime "arrival_date", precision: nil
    t.integer "freetime"
    t.integer "n20_sec"
    t.integer "n40_sec"
    t.integer "n20_frigo"
    t.integer "n40_frigo"
    t.integer "n20_special"
    t.integer "n40_special"
    t.string "reef", limit: 1, default: ""
    t.string "type_depotage", limit: 30
    t.datetime "valid_until", precision: nil
    t.string "status", limit: 30
    t.boolean "exempt", default: false, null: false
    t.boolean "blocked_for_refund", default: false, null: false
    t.string "reference", limit: 60
    t.text "comment"
    t.boolean "valide"
    t.string "released_statut", limit: 20
    t.text "released_comment"
    t.string "operator", limit: 20
    t.string "atp", limit: 30
    t.boolean "consignee_caution", default: false, null: false
    t.string "service_contract", limit: 200
    t.string "bank_account", limit: 30
    t.string "bank_name", limit: 30
    t.string "emails", limit: 60
    t.string "telephone", limit: 20
    t.string "place_receipt", limit: 60
    t.string "place_delivery", limit: 60
    t.string "port_loading", limit: 60
    t.string "port_discharge", limit: 60
    t.index ["arrival_date"], name: "arrival_date"
    t.index ["consignee_code"], name: "consignee_code"
    t.index ["consignee_name"], name: "consignee_name"
    t.index ["number"], name: "numero_bl"
    t.index ["reef"], name: "reef"
  end

  create_table "client", primary_key: "id_client", id: :integer, charset: "latin1", force: :cascade do |t|
    t.string "name", limit: 60, null: false
    t.string "status", limit: 20
    t.string "code", limit: 20
    t.string "group_name", limit: 150, null: false
    t.boolean "pays_deposit", null: false
    t.integer "freetime_frigo"
    t.integer "freetime_sec"
    t.boolean "priority"
    t.integer "salesrepid"
    t.integer "financerepid"
    t.integer "cservrepid"
    t.datetime "valid_until", precision: nil
    t.string "operator", limit: 20
  end

  create_table "facture", primary_key: "id_facture", id: :integer, charset: "utf8mb3", force: :cascade do |t|
    t.string "reference", limit: 10, null: false
    t.string "bill_of_lading_number", limit: 9, null: false, collation: "latin1_swedish_ci"
    t.string "client_code", limit: 20, null: false
    t.string "client_name", limit: 60, null: false
    t.decimal "amount", precision: 12, null: false
    t.decimal "original_amount", precision: 12, scale: 2
    t.string "devise", limit: 6, default: "XOF"
    t.string "status", limit: 10, default: "init", null: false
    t.datetime "invoice_date", precision: nil, null: false
    t.integer "id_utilisateur", null: false
    t.string "create_type_utilisateur", limit: 20
    t.datetime "created_at", precision: nil, null: false
    t.integer "id_utilisateur_update"
    t.datetime "updated_at", precision: nil
    t.index ["bill_of_lading_number"], name: "fk_rails_468196e423"
    t.index ["reference"], name: "unique_reference", unique: true
  end

  create_table "remboursement", primary_key: "id_remboursement", id: :integer, charset: "latin1", force: :cascade do |t|
    t.string "bill_of_lading_number", limit: 9, null: false
    t.string "amount_requested", limit: 15
    t.string "refund_amount", limit: 15
    t.string "deduction", limit: 15
    t.string "status", limit: 10, default: "PENDING"
    t.integer "id_transitaire", null: false
    t.integer "id_transitaire_maison"
    t.boolean "transitaire_notifie"
    t.boolean "maison_notifie"
    t.boolean "banque_notifie"
    t.datetime "date_demande", precision: nil
    t.datetime "date_refund_traite", precision: nil
    t.string "type_paiement", limit: 10
    t.string "pret", limit: 10
    t.string "soumis", limit: 10
    t.string "consignee_code", limit: 14
    t.string "refund_party_name", limit: 200
    t.string "beneficiaire", limit: 20
    t.string "deposit_amount", limit: 15
    t.string "reason_for_refund", limit: 200
    t.string "remarks", limit: 250
    t.string "co_code", limit: 20
    t.text "zm_doc_no"
    t.string "gl_posting_doc", limit: 15
    t.string "clearing_doc", limit: 15
    t.string "email_address", limit: 60
    t.string "type_depotage", limit: 40
    t.boolean "accord_client"
    t.text "comment"
    t.string "reference", limit: 30
    t.datetime "date_agent_notified", precision: nil
    t.datetime "date_agency_notified", precision: nil
    t.datetime "date_client_notified", precision: nil
    t.datetime "date_banque_notified", precision: nil
    t.string "email_agency", limit: 60
    t.string "email_client", limit: 60
    t.index ["bill_of_lading_number"], name: "numero_bl"
    t.index ["date_demande"], name: "date_demande"
    t.index ["reason_for_refund"], name: "reason_for_refund"
    t.index ["status"], name: "statut"
  end

  add_foreign_key "facture", "bl", column: "bill_of_lading_number", primary_key: "number"
end
