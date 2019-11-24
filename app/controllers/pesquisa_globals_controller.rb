class PesquisaGlobalsController < ApplicationController
  def index
    @termo = params[:termo]    
    var = "%#{@termo}%"
    @laboratorio = params[:laboratorio]
    @equipamento = params[:equipamento]
    @servico = params[:servico]
    @postagem = params[:postagem]
    
    if (@termo.blank? && @laboratorio + @equipamento + @servico + @postagem != '0000')
      redirect_to root_path, notice: 'É preciso digitar algo para pesquisar'
    end

    @laboratorios = Laboratorio.where('nome LIKE ?', var) if @laboratorio == '1'
    @equipamentos = Equipamento.where('nome LIKE ?', var) if @equipamento == '1'
    @servicos = Servico.where('nome LIKE ?', var) if @servico == '1'
    @postagems = Postagem.where('titulo LIKE ? OR texto LIKE ?', var, var) if @postagem == '1'

    if (@laboratorio + @equipamento + @servico + @postagem == '0000') then
      redirect_to root_path, notice: 'É preciso selecionar algo para pesquisar'
    elsif ((@laboratorios.nil? || @laboratorios.empty?) && (@equipamentos.nil? || @equipamentos.empty?) && 
      (@servicos.nil? || @servicos.empty?) && (@postagems.nil? || @postagems.empty?)) then
      redirect_to root_path, notice: 'Não foi possível encontrar o termo nas tabelas escolhidas'
    end
  end
end
