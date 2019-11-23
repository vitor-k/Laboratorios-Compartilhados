class Postagem < ApplicationRecord
    belongs_to :user, optional: false
    belongs_to :admin, optional: true
    belongs_to :laboratorio, optional: true

    validates :titulo, presence: true
    validates :texto, presence: true
end

