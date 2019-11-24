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

  def account_postagens
    if (!user_signed_in?)
      redirect_back(fallback_location: root_path)
    end
  end

  def account_recursos_solicitados
    if (!user_signed_in?)
      redirect_back(fallback_location: root_path)
    end
  end

  def indicador_global
    @totEspera = 0
    @totAceito = 0
    @totRejeitado = 0
    @totEqui = 0
    @totServ = 0
  end
end