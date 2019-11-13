class Aluno < ApplicationRecord

  has_one :user, as: :meta, dependent: :destroy
  accepts_nested_attributes_for :user

  belongs_to :laboratorio, optional: true

  validates :nusp, presence: true
  validates :departamento, presence: true
  validates :nusp, numericality: { only_integer: true }

end
