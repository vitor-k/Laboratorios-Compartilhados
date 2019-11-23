class Docente < ApplicationRecord

  has_one :user, as: :meta, dependent: :destroy
  accepts_nested_attributes_for :user

  has_many :responsabilidades, class_name: 'Laboratorio', foreign_key: 'responsavel_id' 
  has_and_belongs_to_many :laboratorios
  
  validates :nusp, presence: true, uniqueness: true
  validate :unique_nusp
  validates :departamento, presence: true
  validates :nusp, numericality: { only_integer: true }

  def unique_nusp
    self.errors.add(:nusp, 'is already taken') if (Aluno.where(nusp: self.nusp).exists? || Admin.where(nusp: self.nusp).exists?)
  end

  def nome
    self.user.nome
  end

  def responsavel?(laboratorio)
    laboratorio.responsavel_id == self.id
  end
end
