class PagesController < ApplicationController

  def home
  end

  def about_us
  end


  def indicador_global
    @totEspera = 0
    @totAceito = 0
    @totRejeitado = 0
    @totEqui = 0
    @totServ = 0
  end
end