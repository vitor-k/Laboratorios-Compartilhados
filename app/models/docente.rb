class Docente < ApplicationRecord

  has_one :user, as: :meta, dependent: :destroy
  accepts_nested_attributes_for :user

  has_many :laboratorios, class_name: 'Laboratorio', foreign_key: 'responsavel_id' 
  belongs_to :laboratorio, optional: true
  
  validates :nusp, presence: true
  validates :departamento, presence: true
  validates :nusp, numericality: { only_integer: true }

  def nome
    self.user.nome
  end
end
