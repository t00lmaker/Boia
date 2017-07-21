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

ActiveRecord::Schema.define(version: 20170721114405) do

  create_table "agendamento", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.boolean  "ativo"
    t.integer  "tipo"
    t.integer  "idColaborador"
    t.date     "data"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.boolean  "diario",        default: false
    t.boolean  "pedir_seg",     default: false
    t.boolean  "pedir_ter",     default: false
    t.boolean  "pedir_qua",     default: false
    t.boolean  "pedir_qui",     default: false
    t.boolean  "pedir_sex",     default: false
  end

  create_table "cardapio", id: :bigint, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.date     "data"
    t.string   "diaSemanaEnum"
    t.datetime "dataCadastro"
    t.string   "feijao"
    t.string   "farofa"
    t.decimal  "valor",                        precision: 19, scale: 2
    t.bigint   "idCardapioAnterior"
    t.binary   "cancelado",          limit: 1
    t.index ["idCardapioAnterior"], name: "FK362A0C5902BE7F0", using: :btree
  end

  create_table "colaborador", id: :bigint, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.bigint "idUsuario"
    t.index ["idUsuario"], name: "FKD0E45A6AA4A4C0DF", using: :btree
  end

  create_table "componentecolecaosituacoes", primary_key: "idColecaoSituacoes", id: :bigint, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
  end

  create_table "config", id: :bigint, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.datetime "data"
    t.decimal  "valor",             precision: 19, scale: 2
    t.string   "horarioTravamento"
    t.string   "horarioAviso"
    t.string   "diaBloqueio"
  end

  create_table "mensagem", primary_key: "idMensagem", id: :bigint, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.datetime "dataMensagem"
    t.string   "assunto",         limit: 50
    t.string   "Mensagem"
    t.string   "tipoMensagem",    limit: 50
    t.binary   "lida",            limit: 1
    t.binary   "avisarRemetente", limit: 1
    t.bigint   "idRemetente",                null: false
    t.bigint   "idDestinatario",             null: false
    t.index ["idDestinatario"], name: "FKDFC72A4BC5ADA198", using: :btree
    t.index ["idRemetente"], name: "FKDFC72A4B2494F94", using: :btree
  end

  create_table "opcao", id: :bigint, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.string "nome"
    t.string "tipoOpcao"
    t.bigint "idCardapio"
    t.index ["idCardapio"], name: "FK48DAA3015C05938", using: :btree
  end

  create_table "pedido", id: :bigint, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.bigint   "idColaborador"
    t.date     "data"
    t.datetime "dataCadastro"
    t.bigint   "carne1"
    t.bigint   "carne2"
    t.bigint   "arroz"
    t.bigint   "salada"
    t.binary   "feijao",           limit: 1
    t.binary   "farofa",           limit: 1
    t.decimal  "valor",                      precision: 19, scale: 2
    t.bigint   "idPedidoAnterior"
    t.binary   "cancelado",        limit: 1
    t.bigint   "idCardapio"
    t.bigint   "macarrao"
    t.string   "observacoes"
    t.bigint   "complemento"
    t.index ["arroz"], name: "FK8E4203653E61F969", using: :btree
    t.index ["carne1"], name: "FK8E420365E751AE63", using: :btree
    t.index ["carne2"], name: "FK8E420365E751AE64", using: :btree
    t.index ["complemento"], name: "FK8E420365506FA466", using: :btree
    t.index ["idCardapio"], name: "FK8E42036515C05938", using: :btree
    t.index ["idColaborador"], name: "FK8E420365F7B15666", using: :btree
    t.index ["idPedidoAnterior"], name: "FK8E42036518BD60B0", using: :btree
    t.index ["macarrao"], name: "FK8E4203652D6E4BBD", using: :btree
    t.index ["salada"], name: "FK8E42036529C4D5D", using: :btree
  end

  create_table "situacao", primary_key: "idSituacao", id: :bigint, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.string   "descricao",          limit: 50
    t.datetime "dataSituacao"
    t.integer  "ordem"
    t.text     "motivo",             limit: 65535
    t.bigint   "idUsuario"
    t.bigint   "idColecaoSituacoes"
    t.index ["idColecaoSituacoes"], name: "FK2D0057C74172F4EB", using: :btree
    t.index ["idUsuario"], name: "FK2D0057C7A4A4C0DF", using: :btree
  end

  create_table "usuario", primary_key: "idUsuario", id: :bigint, force: :cascade, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1" do |t|
    t.string "login",          limit: 20
    t.string "senha",          limit: 20
    t.string "role",           limit: 50
    t.string "local",          limit: 40
    t.string "nome",           limit: 120
    t.string "email"
    t.string "statusUsuario"
    t.string "celular"
    t.binary "recebeMensagem", limit: 1,   default: "b'0'"
    t.index ["login"], name: "login", unique: true, using: :btree
  end

end
