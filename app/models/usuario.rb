class Usuario < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :aluno
  has_one :docente
  has_one :admin
  has_one :representante_externo

  has_many :pedidos
  has_many :postagem
end
