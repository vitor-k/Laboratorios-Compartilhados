class PedidosController < ApplicationController
  before_action :set_pedido, only: [:show, :edit, :update, :destroy]
  before_action :get_solicitador, only: [:show, :edit, :update, :destroy]
  before_action :get_user, only: [:edit, :create, :update, :destroy, :new, :show, :show_lab]
  before_action :get_tipo, only: [:edit, :update, :show, :destroy]
  before_action :out_edit, except: [:edit]

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
    if (@user != nil)
      @tipo = params[:tipo]
      @lab = params[:idLab]
      @item = params[:idItem]
      @pedido = Pedido.new
    else
      respond_to do |format|
        format.html { redirect_to new_pedido_alternativo_path(@tipo, @lab, @item), notice: 'Não tem permissão para fazer pedido.' }
        format.json { head :no_content }
      end
    end
  end

  # GET /pedidos/1/edit
  def edit
    @edit = true
  end

  # POST /pedidos
  # POST /pedidos.json
  def create
    @pedido = @current_user.pedidos.new(pedido_params)
    if (@pedido.equipamento_id != nil)
      @pedido.update_attribute(:laboratorio_id, @pedido.equipamento.laboratorio_id)
    else
      @pedido.update_attribute(:laboratorio_id, @pedido.servico.laboratorio_id)
    end
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
  end

  # PATCH/PUT /pedidos/1
  # PATCH/PUT /pedidos/1.json
  def update
    respond_to do |format|
      if @pedido.update(pedido_params)
        if (@pedido.equipamento_id != nil)
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

  # DELETE /pedidos/1
  # DELETE /pedidos/1.json
  def destroy
    @pedido.destroy
    respond_to do |format|
      format.html { redirect_to pedidos_url, notice: 'Pedido was successfully destroyed.' }
      format.json { head :no_content }
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
    @pedido.update_attribute(:aceito, true)
    if (Pedido.where("(NOT ((dataInicio > ?) OR (dataFim < ?))) AND (aceito = ?) AND (equipamento_id = ? OR servico_id = ?) AND (id != ?)", @pedido.dataFim, @pedido.dataInicio, false, @pedido.equipamento_id, @pedido.servico_id, @pedido.id).exists?)
      Pedido.where("(NOT ((dataInicio > ?) OR (dataFim < ?))) AND (aceito = ?) AND (equipamento_id = ? OR servico_id = ?) AND (id != ?)", @pedido.dataFim, @pedido.dataInicio, false, @pedido.equipamento_id, @pedido.servico_id, @pedido.id).delete_all
    end
    respond_to do |format|
      format.html { redirect_to show_laboratorio_pedidos_path(@lab), notice: 'Pedido aceito com sucesso.'}
      format.json { head :no_content }
    end
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
    
    def out_edit
      @edit = false
    end
end
