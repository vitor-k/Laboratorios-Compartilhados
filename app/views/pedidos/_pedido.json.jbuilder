json.extract! pedido, :id, :data, :descricao, :usuario_id, :equipamento_id, :servico_id, :created_at, :updated_at
json.url pedido_url(pedido, format: :json)
