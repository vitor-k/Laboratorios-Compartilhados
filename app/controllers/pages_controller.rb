class PagesController < ApplicationController

  def home
  end

  def about_us
  end

  def account
    if (docente_signed_in?)
      @docente = Docente.find(current_user.meta_id)
      @laboratorio_docente = @docente.laboratorios
      end
    end

end