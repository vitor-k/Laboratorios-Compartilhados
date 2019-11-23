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
    @tipo = params[:tipo]    
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
    if (@current_user != nil)
      @pedido = @current_user.pedidos.new(pedido_params)
      respond_to do |format|
        if @pedido.save
          format.html { redirect_to @pedido, notice: 'Pedido was successfully created.' }
          format.json { render :show, status: :created, location: @pedido }
        else
          format.html { render :new }
          format.json { render json: @pedido.errors, status: :unprocessable_entity }
        end
      end      
      @pedido.update_attribute(:aceito, false)
      if (@pedido.invalid?)
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
    if (current_user == @solicitador || admin_signed_in? || @user = @lab.responsavel)
      respond_to do |format|
        if @pedido.update(pedido_params)
          if (@pedido.equipamento_id != nil)
            @pedido.update_attribute(:laboratorio_id, @pedido.equipamento.laboratorio_id)
          else
            @pedido.update_attribute(:laboratorio_id, @pedido.servico.laboratorio_id)
          end
          
          if (@user == @solicitador)
            format.html { redirect_to @pedido, notice: 'Pedido was successfully updated.' }
            format.json { render :show, status: :ok, location: @pedido }
          elsif (admin_signed_in?)
            format.html { redirect_to @pedido, notice: 'Pedido was successfully updated.' }
            format.json { render :show, status: :ok, location: @pedido }
          else
            format.html { redirect_to @pedido, notice: 'Pedido was successfully updated.' }
            format.json { render :show, status: :ok, location: @pedido }
          end
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
    @lab = Laboratorio.find(@pedido.laboratorio_id)
    if (current_user == @solicitador || admin_signed_in? || @user = @lab.responsavel)
      @pedido.destroy
      if (current_user == @solicitador)
        respond_to do |format|
          format.html { redirect_to index_user_path(@user), notice: 'Pedido foi deletado.' }
          format.json { head :no_content }
        end
      elsif (admin_signed_in? )
        respond_to do |format|
          format.html { redirect_to pedidos_url, notice: 'Pedido foi deletado.' }
          format.json { head :no_content }
        end
      else
        respond_to do |format|
          format.html { redirect_to show_laboratorio_pedidos_path(@lab), notice: 'Pedido foi deletado.' }
          format.json { head :no_content }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to root_path, notice: 'Não tem permissão.' }
        format.json { head :no_content }
      end
    end
  end

  # get /laboratorios/1/pedidos
  def show_lab
    @lab = Laboratorio.find(params[:idLab])
    @pedido_equipamentos = Pedido.none
    @pedido_servicos = Pedido.none
    @pedido_equipamentos_aceito = Pedido.none
    @pedido_servicos_aceito = Pedido.none
    if (Pedido.where(laboratorio_id: @lab.id, servico_id: nil, aceito: false))
      @pedido_equipamentos = Pedido.where(laboratorio_id: @lab.id, servico_id: nil, aceito: false)
    end
    if (Pedido.where(laboratorio_id: @lab.id, equipamento_id: nil, aceito: true))
      @pedido_servicos = Pedido.where(laboratorio_id: @lab.id, equipamento_id: nil, aceito: false)
    end
    if (Pedido.where(laboratorio_id: @lab.id, servico_id: nil, aceito: true))
      @pedido_equipamentos_aceito = Pedido.where(laboratorio_id: @lab.id, servico_id: nil, aceito: true)
    end
    if (Pedido.where(laboratorio_id: @lab.id, equipamento_id: nil, aceito: true))
      @pedido_servicos_aceito = Pedido.where(laboratorio_id: @lab.id, equipamento_id: nil, aceito: true)
    end
  end

  # post /laboratorios/1/pedidos/1
  def aceitar_pedido    
    @lab = Laboratorio.find(params[:idLab])
    @pedido = Pedido.find(params[:idPedido])
    if (admin_signed_in? || @user == @lab.responsavel)
      @pedido.update_attribute(:aceito, true)
      if (Pedido.where("(NOT ((dataInicio > ?) OR (dataFim < ?))) AND (aceito = ?) AND (equipamento_id = ? OR servico_id = ?) AND (id != ?)", @pedido.dataFim, @pedido.dataInicio, false, @pedido.equipamento_id, @pedido.servico_id, @pedido.id).exists?)
        Pedido.where("(NOT ((dataInicio > ?) OR (dataFim < ?))) AND (aceito = ?) AND (equipamento_id = ? OR servico_id = ?) AND (id != ?)", @pedido.dataFim, @pedido.dataInicio, false, @pedido.equipamento_id, @pedido.servico_id, @pedido.id).delete_all
      end
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
  def index_user
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
      params.require(:pedido).permit(:dataInicio, :dataFim, :descricao, :laboratorio_id, :servico_id, :equipamento_id)
    end

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

    def get_solicitador
      @solicitador = User.find(@pedido.user_id)
    end
    
    def get_tipo      
      # tem um @pedido
      if (@pedido.equipamento_id == nil)
        @tipo = "servico"
      else
        @tipo = "equipamento"
      end
    end

end
