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

ActiveRecord::Schema.define(version: 2019_11_25_185214) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.integer "nusp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "alunos", force: :cascade do |t|
    t.integer "nusp"
    t.string "departamento"
    t.bigint "laboratorio_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["laboratorio_id"], name: "index_alunos_on_laboratorio_id"
  end

  create_table "docentes", force: :cascade do |t|
    t.integer "nusp"
    t.string "departamento"
    t.bigint "laboratorio_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["laboratorio_id"], name: "index_docentes_on_laboratorio_id"
  end

  create_table "docentes_laboratorios", id: false, force: :cascade do |t|
    t.bigint "laboratorio_id", null: false
    t.bigint "docente_id", null: false
  end

  create_table "equipamentos", force: :cascade do |t|
    t.string "nome"
    t.text "funcao"
    t.decimal "taxa"
    t.bigint "laboratorio_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["laboratorio_id"], name: "index_equipamentos_on_laboratorio_id"
  end

  create_table "laboratorios", force: :cascade do |t|
    t.string "nome"
    t.text "localizacao"
    t.text "descricao"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "numero_aceitos", default: 0
    t.integer "numero_rejeitados", default: 0
    t.bigint "responsavel_id"
    t.index ["responsavel_id"], name: "index_laboratorios_on_responsavel_id"
  end

  create_table "pedido_responsabilidades", force: :cascade do |t|
    t.integer "id_laboratorio"
    t.integer "id_docente"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "justificativa"
  end

  create_table "pedidos", force: :cascade do |t|
    t.datetime "data_inicio"
    t.datetime "data_fim"
    t.text "descricao"
    t.bigint "equipamento_id"
    t.bigint "servico_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "aceito"
    t.integer "laboratorio_id"
    t.index ["equipamento_id"], name: "index_pedidos_on_equipamento_id"
    t.index ["servico_id"], name: "index_pedidos_on_servico_id"
    t.index ["user_id"], name: "index_pedidos_on_user_id"
  end

  create_table "postagems", force: :cascade do |t|
    t.text "texto"
    t.string "titulo"
    t.bigint "user_id"
    t.bigint "admin_id"
    t.bigint "laboratorio_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_id"], name: "index_postagems_on_admin_id"
    t.index ["laboratorio_id"], name: "index_postagems_on_laboratorio_id"
    t.index ["user_id"], name: "index_postagems_on_user_id"
  end

  create_table "representante_externos", force: :cascade do |t|
    t.integer "RG"
    t.string "UF"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "servicos", force: :cascade do |t|
    t.string "nome"
    t.text "descricao"
    t.decimal "taxa"
    t.bigint "laboratorio_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["laboratorio_id"], name: "index_servicos_on_laboratorio_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "nome", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "meta_type"
    t.bigint "meta_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["meta_type", "meta_id"], name: "index_users_on_meta_type_and_meta_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "laboratorios", "docentes", column: "responsavel_id"
end
