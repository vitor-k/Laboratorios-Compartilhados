class PedidosController < ApplicationController
  before_action :set_pedido, only: [:show, :edit, :update, :destroy]
  before_action :get_solicitador, only: [:show, :edit, :update, :destroy]
  before_action :get_user, only: [:edit, :create, :update, :destroy, :new, :show, :show_lab, :aceitar_pedido]
  before_action :get_tipo, only: [:edit, :update, :show, :destroy]

  # GET /pedidos
  # GET /pedidos.json
  def index
    @pedidos = Pedido.all
  end

  # GET /pedidos/1
  # GET /pedidos/1.json
  def show
  end

  # GET /pedidos/new
  def new    
    @tipo = params[:tipo] # pega os parametros do laboratorios novo
    @lab = params[:idLab]
    @item = params[:idItem]

    if (@user != nil)
      @pedido = Pedido.new
    else
      respond_to do |format|
        if (@tipo == "equipamento")
          format.html { redirect_to laboratorio_equipamentos_path(@lab), notice: 'Não tem permissão para fazer pedido.' }
          format.json { head :no_content }
        else
          format.html { redirect_to laboratorio_servicos_path(@lab), notice: 'Não tem permissão para fazer pedido.' }
          format.json { head :no_content }
        end
      end
    end
  end

  # GET /pedidos/1/edit
  def edit
  end

  # POST /pedidos
  # POST /pedidos.json
  def create        
    if (@current_user != nil) # se esta logado
      @pedido = @current_user.pedidos.new(pedido_params) # cria o pedido
      respond_to do |format|
        if @pedido.save
          format.html { redirect_to @pedido, notice: 'Pedido was successfully created.' }
          format.json { render :show, status: :created, location: @pedido }
        else
          format.html { render :new }
          format.json { render json: @pedido.errors, status: :unprocessable_entity }
        end
      end      
      @pedido.update_attribute(:aceito, false) # o pedido nao esta aceito
      if (@pedido.invalid?) # se o pedido e invalido e ele foi criado, deletar ele
        @pedido.destroy()
      end
    else
      respond_to do |format|
        format.html { redirect_to new_pedido_path, notice: 'Não tem permissão para fazer pedido.' }
        format.json { head :no_content }
      end
    end
  end

  # PATCH/PUT /pedidos/1
  # PATCH/PUT /pedidos/1.json
  def update 
    @lab = Laboratorio.find(@pedido.laboratorio_id) # pega o laboratorio do pedido
    if (current_user == @solicitador || admin_signed_in? || @user = @lab.responsavel) # precisa ter permissao: admin, responsavel ou a pessoa que fez o pedido
      respond_to do |format|
        if @pedido.update(pedido_params)
          if (@pedido.equipamento_id != nil) # descobre se e equipamento ou servico e escolhe o jeito certo de pegar o id do laboratorio
            @pedido.update_attribute(:laboratorio_id, @pedido.equipamento.laboratorio_id) 
          else
            @pedido.update_attribute(:laboratorio_id, @pedido.servico.laboratorio_id)
          end

          format.html { redirect_to @pedido, notice: 'Pedido was successfully updated.' }
          format.json { render :show, status: :ok, location: @pedido }

        else
          format.html { render :edit }
          format.json { render json: @pedido.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /pedidos/1
  # DELETE /pedidos/1.json
  def destroy
    @lab = Laboratorio.find(@pedido.laboratorio_id) # pega o laboratorio
    era_aceito = @pedido.aceito # se o pedido era aceito, ele nao incrementa a lista de pedidos rejeitados
    if (current_user == @solicitador || admin_signed_in? || @user = @lab.responsavel)
      @pedido.destroy # destroi o pedido
      if (current_user == @solicitador) # rota se o solicitador destroi
        respond_to do |format|
          format.html { redirect_to index_user_path(@user), notice: 'Pedido foi deletado.' }
          format.json { head :no_content }
        end
      elsif (admin_signed_in? ) # rota se o admin destroi
        respond_to do |format|
          format.html { redirect_to pedidos_url, notice: 'Pedido foi deletado.' }
          format.json { head :no_content }
        end
      else # rota se o responsavel destroi
        respond_to do |format|
          format.html { redirect_to show_laboratorio_pedidos_path(@lab), notice: 'Pedido foi deletado.' }
          format.json { head :no_content }
        end
      end
      if (!era_aceito) # se nao era aceito, incrementa o numero de pedidos rejeitados
        @lab.update_attribute(:numero_rejeitados , @lab.numero_rejeitados + 1)
      end
    else # rota se nao tem permissao
      respond_to do |format|
        format.html { redirect_to root_path, notice: 'Não tem permissão.' }
        format.json { head :no_content }
      end
    end
  end

  # get /laboratorios/1/pedidos
  def show_lab # msotra todos os pedidos de um laboratorio
    @lab = Laboratorio.find(params[:idLab])
    @pedido_equipamentos = Pedido.none
    @pedido_servicos = Pedido.none
    @pedido_equipamentos_aceito = Pedido.none
    @pedido_servicos_aceito = Pedido.none
    if (Pedido.where(laboratorio_id: @lab.id, servico_id: nil, aceito: false)) 
      @pedido_equipamentos = Pedido.where(laboratorio_id: @lab.id, servico_id: nil, aceito: false) # equipamentos em espera
    end
    if (Pedido.where(laboratorio_id: @lab.id, equipamento_id: nil, aceito: true))
      @pedido_servicos = Pedido.where(laboratorio_id: @lab.id, equipamento_id: nil, aceito: false) # servicos em espera
    end
    if (Pedido.where(laboratorio_id: @lab.id, servico_id: nil, aceito: true))
      @pedido_equipamentos_aceito = Pedido.where(laboratorio_id: @lab.id, servico_id: nil, aceito: true) # equipamentos aceitos
    end
    if (Pedido.where(laboratorio_id: @lab.id, equipamento_id: nil, aceito: true))
      @pedido_servicos_aceito = Pedido.where(laboratorio_id: @lab.id, equipamento_id: nil, aceito: true) # servicos aceitos
    end
  end

  # post /laboratorios/1/pedidos/1
  def aceitar_pedido    
    @lab = Laboratorio.find(params[:idLab]) # pega o laboratorio
    @pedido = Pedido.find(params[:idPedido]) # pega o pedido
    if (admin_signed_in? || @user == @lab.responsavel) # se tem permissao para aceitar o pedido
      @pedido.update_attribute(:aceito, true) # aceita o pedido
      if (Pedido.where("(NOT ((data_inicio > ?) OR (data_fim < ?))) AND (aceito = ?) AND (equipamento_id = ? OR servico_id = ?) AND (id != ?)", @pedido.data_fim, @pedido.data_inicio, false, @pedido.equipamento_id, @pedido.servico_id, @pedido.id).exists?) # se existe algum pedido sem ser esse, com overlap de horario
         pedidos_deletados = Pedido.where("(NOT ((data_inicio > ?) OR (data_fim < ?))) AND (aceito = ?) AND (equipamento_id = ? OR servico_id = ?) AND (id != ?)", @pedido.data_fim, @pedido.data_inicio, false, @pedido.equipamento_id, @pedido.servico_id, @pedido.id) # seleciona os pedidos com overlap de horario
         @lab.update_attribute(:numero_rejeitados , @lab.numero_rejeitados + pedidos_deletados.count()) # incrementa o numero de pedidos rejeitados de acordo com o numero de pedidos que deram overlap de horario
         pedidos_deletados.delete_all # deleta todos os pedidos selecionados
      end
      @lab.update_attribute(:numero_aceitos , @lab.numero_aceitos + 1) # incrementa o numero de pedidos aceitos
      respond_to do |format|
        format.html { redirect_to show_laboratorio_pedidos_path(@lab), notice: 'Pedido aceito com sucesso.'} 
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to root_path, notice: 'Você não tem permissão.'}
        format.json { head :no_content }
      end
    end
  end

  # get /account/1/pedidos
  def index_user # pega a lista de pedidso de um usuario, separando por tipo e se estao aceitos ou nao 
    @equipamentos_espera = current_user.pedidos.where(servico_id: nil, aceito: false)
    @servicos_espera = current_user.pedidos.where(equipamento_id: nil, aceito: false)
    @equipamentos_aceito = current_user.pedidos.where(servico_id: nil, aceito: true)
    @servicos_aceito  = current_user.pedidos.where(equipamento_id: nil, aceito: true)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pedido
      @pedido = Pedido.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pedido_params
      params.require(:pedido).permit(:data_inicio, :data_fim, :descricao, :laboratorio_id, :servico_id, :equipamento_id)
    end

    # current_user
    def get_user
      @user ||=
        if aluno_signed_in?
          id = current_aluno.id
          @user = Aluno.find(id)
        elsif representante_externo_signed_in?
          id = current_representante_externo.id
          @user = RepresentanteExterno.find(id)
        elsif admin_signed_in?
          id = current_admin.id
          @user = Admin.find(id)
        elsif docente_signed_in?
          id = current_docente.id
          @user = Docente.find(id)
        else
          @user = nil;
        end
    end

    # pega o solicitador de um pedido
    def get_solicitador
      @solicitador = User.find(@pedido.user_id)
    end
    
    # pega o tipo do pedido
    def get_tipo      
      # tem um @pedido
      if (@pedido.equipamento_id == nil)
        @tipo = "servico"
      else
        @tipo = "equipamento"
      end
    end

end
