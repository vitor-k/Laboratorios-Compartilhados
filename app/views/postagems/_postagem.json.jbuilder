json.extract! postagem, :id, :texto, :created_at, :updated_at
json.url postagem_url(postagem, format: :json)
