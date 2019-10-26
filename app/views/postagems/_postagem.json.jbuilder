json.extract! postagem, :id, :texto, :usuario_id, :laboratorio_id, :created_at, :updated_at
json.url postagem_url(postagem, format: :json)
