class PedidosController < ApplicationController
  before_action :set_pedido, only: [:show, :edit, :update, :destroy]
  before_action :getSolicitador, only: [:show, :edit, :update, :destroy]
  before_action :get_user, only: [:edit, :create, :update, :destroy, :new]

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
      @pedido = Pedido.new
    end
  end

  # GET /pedidos/1/edit
  def edit
  end

  # POST /pedidos
  # POST /pedidos.json
  def create
    @pedido = @user.pedidos.build(pedido_params)
    respond_to do |format|
      if @pedido.save
        format.html { redirect_to @pedido, notice: 'Pedido was successfully created.' }
        format.json { render :show, status: :created, location: @pedido }
      else
        format.html { render :new }
        format.json { render json: @pedido.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pedidos/1
  # PATCH/PUT /pedidos/1.json
  def update
    respond_to do |format|
      if @pedido.update(pedido_params)
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

    def getSolicitador
      if (@pedido.aluno_id != nil)
          @solicitador = Aluno.find(@pedido.aluno_id)    
      elsif (@pedido.docente_id != nil)
          @solicitador = Docente.find(@pedido.docente_id)   
      elsif (@pedido.representante_externo_id != nil)
          @solicitador = Representante_externo.find(@pedido.representante_externo_id)
      elsif (@pedido.admin_id != nil)
          @solicitador = Admin.find(@pedido.admin_id)
      end
    end
end
