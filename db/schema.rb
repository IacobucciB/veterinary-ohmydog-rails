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

ActiveRecord::Schema[7.0].define(version: 2023_12_12_185608) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "adopcions", force: :cascade do |t|
    t.integer "tamanio"
    t.integer "sexo"
    t.string "origen"
    t.integer "estado"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "persona_id", null: false
    t.bigint "tipo_raza_id", null: false
    t.index ["persona_id"], name: "index_adopcions_on_persona_id"
    t.index ["tipo_raza_id"], name: "index_adopcions_on_tipo_raza_id"
  end

  create_table "campania_donacions", force: :cascade do |t|
    t.string "nombre"
    t.string "descripcion"
    t.datetime "fecha_final"
    t.decimal "monto_actual", precision: 10, scale: 2
    t.decimal "monto_objetivo", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "encontrados", force: :cascade do |t|
    t.integer "estado"
    t.string "lugar"
    t.date "dia"
    t.text "descripcion"
    t.string "color"
    t.integer "tamanio"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_encontrados_on_user_id"
  end

  create_table "paseadors", force: :cascade do |t|
    t.string "name"
    t.integer "service_type"
    t.string "email"
    t.string "location"
    t.bigint "plaza_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plaza_id"], name: "index_paseadors_on_plaza_id"
  end

  create_table "perdido_encontrados", force: :cascade do |t|
    t.string "zona"
    t.date "dia"
    t.string "observacion"
    t.integer "estado"
    t.integer "tipo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "perro_id", null: false
    t.index ["perro_id"], name: "index_perdido_encontrados_on_perro_id"
  end

  create_table "perdidoencontrados", force: :cascade do |t|
    t.string "tipo"
    t.string "foto"
    t.string "zona"
    t.datetime "dia"
    t.string "observacion"
    t.string "estado"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "perros", force: :cascade do |t|
    t.string "nombre"
    t.integer "edad"
    t.string "color"
    t.string "descripcion"
    t.string "antecedentes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "persona_id", null: false
    t.bigint "tipo_raza_id", null: false
    t.integer "sexo"
    t.boolean "is_active", default: true
    t.boolean "is_lost", default: false
    t.index ["persona_id"], name: "index_perros_on_persona_id"
    t.index ["tipo_raza_id"], name: "index_perros_on_tipo_raza_id"
  end

  create_table "personas", force: :cascade do |t|
    t.string "nombre", null: false
    t.string "apellido"
    t.bigint "dni"
    t.bigint "telefono"
    t.date "nacimiento"
    t.boolean "donante"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["dni"], name: "index_personas_on_dni", unique: true
    t.index ["user_id"], name: "index_personas_on_user_id"
  end

  create_table "plazas", force: :cascade do |t|
    t.string "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tarjeta_creditos", force: :cascade do |t|
    t.string "numero"
    t.string "nombre"
    t.date "fecha_vencimiento"
    t.integer "codigo_seguridad"
    t.decimal "saldo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tipo_razas", force: :cascade do |t|
    t.string "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tipo_turnos", force: :cascade do |t|
    t.string "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "turnos", force: :cascade do |t|
    t.date "dia"
    t.integer "franja_horaria"
    t.integer "estado"
    t.float "monto"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "perro_id", null: false
    t.bigint "tipo_turno_id", null: false
    t.integer "dosis"
    t.string "descripcion"
    t.integer "peso"
    t.time "hora"
    t.index ["perro_id"], name: "index_turnos_on_perro_id"
    t.index ["tipo_turno_id"], name: "index_turnos_on_tipo_turno_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role"
    t.boolean "is_active", default: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "adopcions", "personas"
  add_foreign_key "adopcions", "tipo_razas"
  add_foreign_key "encontrados", "users"
  add_foreign_key "paseadors", "plazas"
  add_foreign_key "perdido_encontrados", "perros"
  add_foreign_key "perros", "personas"
  add_foreign_key "perros", "tipo_razas"
  add_foreign_key "personas", "users"
  add_foreign_key "turnos", "perros"
  add_foreign_key "turnos", "tipo_turnos"
end
