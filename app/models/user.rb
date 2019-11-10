class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :meta, polymorphic: true

  def admin?
    self.meta_type == 'Admin'
  end

  def aluno?
    self.meta_type == 'Aluno'
  end

  def representante_externo?
    self.meta_type == 'RepresentanteExterno'
  end

  def docente?
    self.meta_type == 'Docente'
  end
end
