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

    @laboratorios = Laboratorio.where('lower(nome) LIKE ?', var.downcase) if @laboratorio == '1'
    @equipamentos = Equipamento.where('lower(nome) LIKE ?', var.downcase) if @equipamento == '1'
    @servicos = Servico.where('lower(nome) LIKE ?', var.downcase) if @servico == '1'
    @postagems = Postagem.where('lower(titulo) LIKE ? OR lower(texto) LIKE ?', var.downcase, var.downcase) if @postagem == '1'

    if (@laboratorio + @equipamento + @servico + @postagem == '0000') then
      redirect_to root_path, notice: 'É preciso selecionar algo para pesquisar'
    elsif ((@laboratorios.nil? || @laboratorios.empty?) && (@equipamentos.nil? || @equipamentos.empty?) && 
      (@servicos.nil? || @servicos.empty?) && (@postagems.nil? || @postagems.empty?)) then
      redirect_to root_path, notice: 'Não foi possível encontrar o termo nas tabelas escolhidas'
    end
  end
end
