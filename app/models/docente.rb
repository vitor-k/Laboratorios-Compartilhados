class Docente < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  has_many :postagems, dependent: :destroy
  has_many :pedidos, dependent: :destroy
  has_many :laboratorios, class_name: 'Laboratorio', foreign_key: 'responsavel_id' 
  belongs_to :laboratorio, optional: true
  
  validates :nome, presence: true
  validates :nusp, presence: true
  validates :departamento, presence: true
  validates :nusp, numericality: { only_integer: true }
end
