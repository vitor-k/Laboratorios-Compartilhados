class RepresentanteExterno < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  has_many :postagems, dependent: :destroy
  has_many :pedidos, dependent: :destroy
  
  validates :nome, presence: true
  validates :RG, presence: true
  validates :RG, numericality: { only_integer: true }
  validates :UF, presence: true
end
