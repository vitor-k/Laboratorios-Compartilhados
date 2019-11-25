json.array! @pedidos, partial: "pedidos/pedido", as: :pedido

json.array!(@pedidos.where(laboratorio_id: 1)) do |pedido|  
    json.title pedido.descricao 
    json.start pedido.dataInicio   
    json.end pedido.dataFim
    json.color '111111'
  end