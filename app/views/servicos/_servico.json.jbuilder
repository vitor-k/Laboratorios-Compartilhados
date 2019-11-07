json.extract! servico, :id, :nome, :descricao, :taxa, :created_at, :updated_at
json.url servico_url(servico, format: :json)
