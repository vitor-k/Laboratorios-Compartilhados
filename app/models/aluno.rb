class Aluno < ApplicationRecord

  has_one :user, as: :meta, dependent: :destroy
  accepts_nested_attributes_for :user

  belongs_to :laboratorio, optional: true

  validates :nusp, presence: true, uniqueness: true
  validate :unique_nusp
  validates :departamento, presence: true
  validates :nusp, numericality: { only_integer: true }

  def unique_nusp
    self.errors.add(:nusp, 'is already taken') if (Docente.where(nusp: self.nusp).exists? || Admin.where(nusp: self.nusp).exists?)
  end
end
