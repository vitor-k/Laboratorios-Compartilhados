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

  def aluno_signed_in?
    user_signed_in? && current_user.aluno?
  end

  def docente_signed_in?
    user_signed_in? && current_user.docente?
  end

  def representante_externo_signed_in?
    user_signed_in? && current_user.representante_externo?
  end

  def admin_signed_in?
    user_signed_in? && current_user.admin?
  end

  def current_aluno
    Aluno.find(self.meta_id) if self.aluno?
  end

  def current_docente
    Docente.find(self.meta_id) if self.docente?
  end

  def current_representante_externo
    RepresentanteExterno.find(self.meta_id) if self.representante_externo?
  end

  def current_admin
    Admin.find(self.meta_id) if self.admin?
  end
end
