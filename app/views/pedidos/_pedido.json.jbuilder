json.extract! pedido, :id, :dataInicio, :dataFim, :descricao, :created_at, :updated_at
json.url pedido_url(pedido, format: :json)
