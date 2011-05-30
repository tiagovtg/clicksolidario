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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110512145628) do

  create_table "bancos", :force => true do |t|
    t.string   "nome",       :limit => 30
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "causas", :force => true do |t|
    t.string   "nome",       :limit => 20
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "conta", :force => true do |t|
    t.string   "nome",        :limit => 70
    t.string   "numero",      :limit => 10
    t.string   "operacao",    :limit => 10
    t.string   "agencia",     :limit => 30
    t.integer  "entidade_id"
    t.integer  "banco_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "count_mails", :force => true do |t|
    t.integer  "enviados"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "doacaos", :force => true do |t|
    t.decimal  "valor",         :precision => 9, :scale => 2
    t.date     "data"
    t.boolean  "valida"
    t.text     "obs"
    t.integer  "voluntario_id"
    t.integer  "empresa_id"
    t.integer  "entidade_id"
    t.integer  "doatipo_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "doatipos", :force => true do |t|
    t.string   "nome",       :limit => 70
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "emergencia", :force => true do |t|
    t.string   "titulo"
    t.string   "resumo"
    t.text     "emergencia"
    t.date     "data"
    t.string   "status"
    t.string   "imagem_file_name",    :null => false
    t.string   "imagem_content_type", :null => false
    t.integer  "imagem_file_size",    :null => false
    t.datetime "imagem_updated_at",   :null => false
    t.boolean  "validacao"
    t.integer  "entidade_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "empresas", :force => true do |t|
    t.string   "nomefantasia",  :limit => 100
    t.string   "razaosocial",   :limit => 200
    t.string   "cnpj",          :limit => 18
    t.string   "ramoatividade", :limit => 100
    t.string   "areaatuacao",   :limit => 70
    t.string   "site",          :limit => 100
    t.string   "nome",          :limit => 70
    t.string   "apelido",       :limit => 30
    t.date     "datanasc"
    t.string   "cpf",           :limit => 14
    t.string   "sexo",          :limit => 9
    t.string   "cep",           :limit => 10
    t.string   "endereco",      :limit => 70
    t.string   "numero",        :limit => 10
    t.string   "complemento",   :limit => 70
    t.string   "bairro",        :limit => 70
    t.string   "cidade",        :limit => 40
    t.string   "estado",        :limit => 2
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "entidades", :force => true do |t|
    t.string   "nomefantasia", :limit => 100
    t.string   "razaosocial",  :limit => 200
    t.string   "cnpj",         :limit => 18
    t.string   "areaatuacao",  :limit => 70
    t.date     "datafunda"
    t.string   "site",         :limit => 70
    t.string   "siteproprio",  :limit => 3
    t.string   "nome",         :limit => 70
    t.string   "apelido",      :limit => 30
    t.date     "datanasc"
    t.string   "cpf",          :limit => 14
    t.string   "sexo",         :limit => 9
    t.string   "cep",          :limit => 10
    t.string   "endereco",     :limit => 70
    t.string   "numero",       :limit => 10
    t.string   "complemento",  :limit => 70
    t.string   "bairro",       :limit => 70
    t.string   "cidade",       :limit => 40
    t.string   "estado",       :limit => 2
    t.integer  "causa_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "newsletters", :force => true do |t|
    t.string   "nome",       :limit => 70
    t.string   "email",      :limit => 100
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "noticia", :force => true do |t|
    t.string   "titulo"
    t.string   "resumo"
    t.text     "noticia"
    t.date     "data"
    t.boolean  "validacao"
    t.integer  "entidade_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string   "name",              :limit => 40
    t.string   "authorizable_type", :limit => 40
    t.integer  "authorizable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "telefones", :force => true do |t|
    t.string   "ddd",           :limit => 2
    t.string   "numero",        :limit => 9
    t.string   "tipo",          :limit => 15
    t.integer  "entidade_id"
    t.integer  "empresa_id"
    t.integer  "voluntario_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",               :limit => 70,                 :null => false
    t.string   "crypted_password",                                  :null => false
    t.string   "password_salt",                                     :null => false
    t.string   "persistence_token",                                 :null => false
    t.string   "single_access_token",                               :null => false
    t.string   "perishable_token",                                  :null => false
    t.integer  "failed_login_count",                 :default => 0, :null => false
    t.datetime "last_request_at"
    t.string   "current_login_ip",    :limit => 30
    t.string   "status",              :limit => 10,                 :null => false
    t.string   "nome",                :limit => 100
    t.boolean  "newsletter"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "voluntarios", :force => true do |t|
    t.string   "nome",        :limit => 70
    t.string   "apelido",     :limit => 30
    t.date     "datanasc"
    t.string   "cpf",         :limit => 14
    t.string   "sexo",        :limit => 9
    t.string   "profissao",   :limit => 70
    t.string   "cep",         :limit => 10
    t.string   "endereco",    :limit => 70
    t.string   "numero",      :limit => 10
    t.string   "complemento", :limit => 70
    t.string   "bairro",      :limit => 70
    t.string   "cidade",      :limit => 40
    t.string   "estado",      :limit => 2
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
