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

ActiveRecord::Schema.define(version: 2019_11_08_210600) do

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "nome", default: "", null: false
    t.integer "nusp"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "alunos", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "nome", default: "", null: false
    t.integer "nusp"
    t.string "departamento"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_alunos_on_email", unique: true
    t.index ["reset_password_token"], name: "index_alunos_on_reset_password_token", unique: true
  end

  create_table "docentes", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "nome", default: "", null: false
    t.integer "nusp"
    t.string "departamento"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_docentes_on_email", unique: true
    t.index ["reset_password_token"], name: "index_docentes_on_reset_password_token", unique: true
  end

  create_table "equipamentos", force: :cascade do |t|
    t.text "nome"
    t.text "funcao"
    t.decimal "taxa"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "laboratorios", force: :cascade do |t|
    t.text "nome"
    t.text "localizacao"
    t.text "descricao"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "responsavel_id"
    t.index ["responsavel_id"], name: "index_laboratorios_on_responsavel_id"
  end

  create_table "pedidos", force: :cascade do |t|
    t.datetime "dataInicio"
    t.datetime "dataFim"
    t.text "descricao"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "postagems", force: :cascade do |t|
    t.text "texto"
    t.integer "aluno_id"
    t.integer "docente_id"
    t.integer "representante_externo_id"
    t.integer "admin_id"
    t.integer "laboratorio_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "representante_externos", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "nome", default: "", null: false
    t.string "RG"
    t.string "UF"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_representante_externos_on_email", unique: true
    t.index ["reset_password_token"], name: "index_representante_externos_on_reset_password_token", unique: true
  end

  create_table "servicos", force: :cascade do |t|
    t.text "nome"
    t.text "descricao"
    t.decimal "taxa"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
