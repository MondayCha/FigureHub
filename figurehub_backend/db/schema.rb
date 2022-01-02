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

ActiveRecord::Schema.define(version: 2021_12_27_123003) do

  create_table "character_images", force: :cascade do |t|
    t.string "url"
    t.integer "character_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_character_images_on_character_id"
  end

  create_table "characters", force: :cascade do |t|
    t.string "name"
    t.integer "gender"
    t.text "info"
    t.integer "origin_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["origin_id"], name: "index_characters_on_origin_id"
  end

  create_table "collections", force: :cascade do |t|
    t.integer "user_id"
    t.integer "merchandise_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["merchandise_id"], name: "index_collections_on_merchandise_id"
    t.index ["user_id"], name: "index_collections_on_user_id"
  end

  create_table "comment_likes", force: :cascade do |t|
    t.integer "figure_comment_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["figure_comment_id"], name: "index_comment_likes_on_figure_comment_id"
    t.index ["user_id"], name: "index_comment_likes_on_user_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "deal_comments", force: :cascade do |t|
    t.integer "deal_id"
    t.string "content"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deal_id"], name: "index_deal_comments_on_deal_id"
    t.index ["user_id"], name: "index_deal_comments_on_user_id"
  end

  create_table "deals", force: :cascade do |t|
    t.integer "merchandise_id"
    t.integer "status"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["merchandise_id"], name: "index_deals_on_merchandise_id"
    t.index ["user_id"], name: "index_deals_on_user_id"
  end

  create_table "figure_character_associations", force: :cascade do |t|
    t.integer "figure_id"
    t.integer "character_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_figure_character_associations_on_character_id"
    t.index ["figure_id"], name: "index_figure_character_associations_on_figure_id"
  end

  create_table "figure_comments", force: :cascade do |t|
    t.integer "figure_id"
    t.string "content"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["figure_id"], name: "index_figure_comments_on_figure_id"
    t.index ["user_id"], name: "index_figure_comments_on_user_id"
  end

  create_table "figure_images", force: :cascade do |t|
    t.string "url"
    t.integer "figure_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["figure_id"], name: "index_figure_images_on_figure_id"
  end

  create_table "figures", force: :cascade do |t|
    t.string "name"
    t.integer "kind"
    t.decimal "price"
    t.string "scale"
    t.integer "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_figures_on_company_id"
  end

  create_table "merchandise_images", force: :cascade do |t|
    t.string "url"
    t.integer "merchandise_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["merchandise_id"], name: "index_merchandise_images_on_merchandise_id"
  end

  create_table "merchandises", force: :cascade do |t|
    t.decimal "price"
    t.integer "status"
    t.integer "kind"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_merchandises_on_user_id"
  end

  create_table "origins", force: :cascade do |t|
    t.string "name"
    t.integer "kind"
    t.text "info"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sales", force: :cascade do |t|
    t.integer "merchandise_id"
    t.integer "figure_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["figure_id"], name: "index_sales_on_figure_id"
    t.index ["merchandise_id"], name: "index_sales_on_merchandise_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "nickname"
    t.integer "kind"
    t.string "avatar"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
