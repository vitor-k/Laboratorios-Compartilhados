class PagesController < ApplicationController

  def home
  end

  def about_us
  end

  def account
    if (current_user.docente?)
      docente = (Docente.find(current_user.meta_id))
      @laboratorio_docente = Laboratorio.all
      @laboratorio_docente.find_each do |cada|
        if (cada.docentes.where.not(id: docente.id).exists?)
          @laboratorio_docente.drop(cada.id)
        end
      end
    end
  end

end