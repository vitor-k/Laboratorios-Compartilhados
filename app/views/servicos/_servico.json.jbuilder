json.extract! servico, :id, :nome, :funcao, :taxa, :laboratorio_id, :created_at, :updated_at
json.url servico_url(servico, format: :json)
