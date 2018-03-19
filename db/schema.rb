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

ActiveRecord::Schema.define(version: 20180317030347) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "entradas", force: :cascade do |t|
    t.bigint "pedido_id"
    t.bigint "producto_id"
    t.integer "cantidad"
    t.float "importe"
    t.index ["pedido_id"], name: "index_entradas_on_pedido_id"
    t.index ["producto_id"], name: "index_entradas_on_producto_id"
  end

  create_table "pedidos", force: :cascade do |t|
    t.integer "user_id"
    t.float "total"
    t.float "iva"
    t.float "subtotal"
  end

  create_table "productos", force: :cascade do |t|
    t.string "nombre"
    t.float "precio"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "apellido"
  end

  add_foreign_key "entradas", "pedidos"
  add_foreign_key "entradas", "productos"
end
