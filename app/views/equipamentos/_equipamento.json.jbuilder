json.extract! equipamento, :id, :nome, :funcao, :taxa, :laboratorio_id, :created_at, :updated_at
json.url equipamento_url(equipamento, format: :json)
