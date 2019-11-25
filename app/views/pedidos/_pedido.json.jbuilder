json.extract! pedido, :id, :data_inicio, :data_fim, :descricao, :created_at, :updated_at
json.url pedido_url(pedido, format: :json)
