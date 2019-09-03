# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20161230162251) do

  create_table "account_banks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "bank_list_id"
    t.integer  "account_id"
    t.string   "bank_account_number"
    t.string   "bank_holder_name"
    t.boolean  "verified"
    t.datetime "verified_at"
    t.integer  "verified_by"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.index ["account_id"], name: "index_account_banks_on_account_id", using: :btree
    t.index ["bank_list_id"], name: "index_account_banks_on_bank_list_id", using: :btree
  end

  create_table "account_purchase_items", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.decimal  "item_price",                 precision: 10, scale: 2
    t.string   "item_name"
    t.text     "item_desc",    limit: 65535
    t.integer  "account_id"
    t.integer  "business_id"
    t.boolean  "is_completed"
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
    t.index ["account_id"], name: "index_account_purchase_items_on_account_id", using: :btree
    t.index ["business_id"], name: "index_account_purchase_items_on_business_id", using: :btree
  end

  create_table "account_rechargers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "serial_number"
    t.decimal  "card_number",     precision: 16
    t.integer  "amount"
    t.datetime "expiration_date"
    t.datetime "created_at"
    t.integer  "created_by"
  end

  create_table "account_transaction_statuses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "account_transaction_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "account_transactions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "transaction_id"
    t.string   "title"
    t.decimal  "amount",                                      precision: 10, scale: 2
    t.decimal  "initial_balance",                             precision: 10, scale: 2
    t.decimal  "closing_balance",                             precision: 10, scale: 2
    t.integer  "account_transaction_type_id"
    t.integer  "account_id"
    t.integer  "account_transaction_status_id"
    t.text     "note",                          limit: 65535
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at",                                                           null: false
    t.datetime "updated_at",                                                           null: false
    t.index ["account_id"], name: "index_account_transactions_on_account_id", using: :btree
    t.index ["account_transaction_status_id"], name: "index_account_transactions_on_account_transaction_status_id", using: :btree
    t.index ["account_transaction_type_id"], name: "index_account_transactions_on_account_transaction_type_id", using: :btree
  end

  create_table "account_transfer_histories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.decimal  "transfer_amount", precision: 10, scale: 2
    t.datetime "transfer_on"
    t.integer  "receiver_id"
    t.integer  "account_id"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.index ["account_id"], name: "index_account_transfer_histories_on_account_id", using: :btree
    t.index ["receiver_id"], name: "index_account_transfer_histories_on_receiver_id", using: :btree
  end

  create_table "account_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "accounts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "account_id"
    t.decimal  "initial_balance", precision: 10, scale: 2
    t.decimal  "current_balance", precision: 10, scale: 2
    t.date     "close_date"
    t.integer  "account_type_id"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.index ["account_type_id"], name: "index_accounts_on_account_type_id", using: :btree
  end

  create_table "balance_card_histories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.decimal  "fund_amount",     precision: 10, scale: 2
    t.datetime "fund_on"
    t.integer  "balance_card_id"
    t.integer  "account_id"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.index ["account_id"], name: "index_balance_card_histories_on_account_id", using: :btree
    t.index ["balance_card_id"], name: "index_balance_card_histories_on_balance_card_id", using: :btree
  end

  create_table "balance_cards", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "card_code"
    t.integer  "serial_number"
    t.decimal  "initial_balance", precision: 10, scale: 2
    t.decimal  "current_balance", precision: 10, scale: 2
    t.datetime "expired_at"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  create_table "bank_lists", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "address_line_1"
    t.string   "address_line_2"
    t.string   "city"
    t.string   "state"
    t.boolean  "is_international"
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "user_infos", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "gender"
    t.date     "birth_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_traces", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "sign_in_at"
    t.string   "sign_in_ip"
    t.integer  "user_id"
    t.index ["user_id"], name: "index_user_traces_on_user_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "remember_digest"
    t.string   "activation_digest"
    t.boolean  "activated",         default: false
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
    t.integer  "account_id"
    t.integer  "user_info_id"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.index ["account_id"], name: "index_users_on_account_id", using: :btree
    t.index ["user_info_id"], name: "index_users_on_user_info_id", using: :btree
  end

  add_foreign_key "account_banks", "accounts"
  add_foreign_key "account_banks", "bank_lists"
  add_foreign_key "account_purchase_items", "accounts"
  add_foreign_key "account_purchase_items", "accounts", column: "business_id"
  add_foreign_key "account_transactions", "account_transaction_statuses"
  add_foreign_key "account_transactions", "account_transaction_types"
  add_foreign_key "account_transactions", "accounts"
  add_foreign_key "account_transfer_histories", "accounts"
  add_foreign_key "account_transfer_histories", "accounts", column: "receiver_id"
  add_foreign_key "accounts", "account_types"
  add_foreign_key "balance_card_histories", "accounts"
  add_foreign_key "balance_card_histories", "balance_cards"
  add_foreign_key "user_traces", "users"
  add_foreign_key "users", "accounts"
  add_foreign_key "users", "user_infos"
end
