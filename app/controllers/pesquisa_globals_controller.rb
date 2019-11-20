class PesquisaGlobalsController < ApplicationController
  def index
    puts 'hello :)'
    puts params[:termo]
    #redirect_back
    @termo = params[:termo]
    var = "%#{@termo}%"
    laboratorio = params[:laboratorio]
    puts "laboratorio = #{laboratorio}"
    equipamento = params[:equipamento]
    servico = params[:servico]
    postagem = params[:postagem]
    
    # @laboratorios = laboratorio == '1' ? Laboratorio.where('nome LIKE ?', var) : []
    @laboratorios = Laboratorio.where('nome LIKE ?', var) if laboratorio == '1'
    @equipamentos = Equipamento.where('nome LIKE ?', var) if equipamento == '1'
    @servicos = Servico.where('nome LIKE ?', var) if servico == '1'
    @postagems = Postagem.where('titulo LIKE ? OR texto LIKE ?', var, var) if servico == '1'
  end
end
