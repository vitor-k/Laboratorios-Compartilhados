class PedidoResponsabilidadesController < ApplicationController
  before_action :set_pedido_responsabilidade, only: [:show, :edit, :update, :destroy, :aceitar]
  before_action :get_solicitador_responsabilidade, only: [:permissao_existente]
  before_action :get_user, only: [:get_solicitador_responsabilidade]
  before_action :permissao_novo, only: [:new, :create]
  before_action :permissao_existente, only: [:edit, :update, :destroy]

  # GET /pedido_responsabilidades
  # GET /pedido_responsabilidades.json
  def index
    @pedido_responsabilidades = PedidoResponsabilidade.all
  end

  #GET /account/:id/pedido_responsabilidade
  def index_docente
    if (PedidoResponsabilidade.where(id_docente: current_user.id).exists?)
      @pedido_responsabilidades_this = PedidoResponsabilidade.where(id_docente: current_user.id)
    else
      @pedido_responsabilidades_this = nil
    end
  end

  # GET /pedido_responsabilidades/1
  # GET /pedido_responsabilidades/1.json
  def show
  end

  # GET /pedido_responsabilidades/new
  def new
    if (@permissao_novo)
      @pedido_responsabilidade = PedidoResponsabilidade.new
    end
  end

  # GET /pedido_responsabilidades/1/edit
  def edit
  end

  # POST /pedido_responsabilidades
  # POST /pedido_responsabilidades.json
  def create
    @pedido_responsabilidade = PedidoResponsabilidade.new(pedido_responsabilidade_params)
    if (@permissao_novo && Laboratorio.find(@pedido_responsabilidade.id_laboratorio).responsavel == nil)
      @pedido_responsabilidade.id_docente = current_user.id
      respond_to do |format|
        if @pedido_responsabilidade.save
          format.html { redirect_to account_path, notice: 'Pedido responsabilidade was successfully created.' }
          format.json { render :show, status: :created, location: @pedido_responsabilidade }
        else
          format.html { render :new }
          format.json { render json: @pedido_responsabilidade.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to account_path, notice: 'Não foi possível solicitar responsabilidade.' }
        format.json { head :no_content }
      end
    end
  end

  # PATCH/PUT /pedido_responsabilidades/1
  # PATCH/PUT /pedido_responsabilidades/1.json
  def update
    if (@permissao_existente && Laboratorio.find(@pedido_responsabilidade.id_laboratorio).responsavel == nil)
      respond_to do |format|
        if @pedido_responsabilidade.update(pedido_responsabilidade_params)
          format.html { redirect_to account_path, notice: 'Pedido responsabilidade was successfully updated.' }
          format.json { render :show, status: :ok, location: @pedido_responsabilidade }
        else
          format.html { render :edit }
          format.json { render json: @pedido_responsabilidade.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to account_path, notice: 'Não foi possivel editar solicitação de responsabilidade.' }
        format.json { head :no_content }
      end
    end
  end

  # DELETE /pedido_responsabilidades/1
  # DELETE /pedido_responsabilidades/1.json
  def destroy
    if (@permissao_existente)
      if (admin_signed_in?)
        @pedido_responsabilidade.destroy
        respond_to do |format|
          format.html { redirect_to pedido_responsabilidades_path, notice: 'Solicitação de responsabilidade deletada.' }
          format.json { head :no_content }
        end
      else
        @pedido_responsabilidade.destroy
        respond_to do |format|
          format.html { redirect_to account_path, notice: 'Solicitação de responsabilidade deletada.' }
          format.json { head :no_content }
        end
      end
    end
  end

  # PUT
  def aceitar
    if (admin_signed_in? || true)
      puts @pedido_responsabilidade            

      puts "O laboratório é #{ Laboratorio.find(@pedido_responsabilidade.id_laboratorio).nome}"
      puts "O novo responsável é #{User.find(@pedido_responsabilidade.id_docente).nome} e id #{User.find(@pedido_responsabilidade.id_docente).meta_id}"

      Laboratorio.find(@pedido_responsabilidade.id_laboratorio).update(responsavel_id: User.find(@pedido_responsabilidade.id_docente).meta_id) #Adiciona o docente como responsavel
      Laboratorio.find(@pedido_responsabilidade.id_laboratorio).docentes << Docente.find(User.find(@pedido_responsabilidade.id_docente).meta_id) #Adiciona o responsavel como membro

      puts "Depois ficou #{Laboratorio.find(@pedido_responsabilidade.id_laboratorio).responsavel_id}"

      @pedido_responsabilidades_afetados = PedidoResponsabilidade.where(id_laboratorio: @pedido_responsabilidade.id_laboratorio)
      @pedido_responsabilidades_afetados.find_each do |cada|
        cada.destroy
      end
      respond_to do |format|
        format.html { redirect_to pedido_responsabilidades_path, notice: 'Solicitação aceita.' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pedido_responsabilidade
      @pedido_responsabilidade = PedidoResponsabilidade.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pedido_responsabilidade_params
      params.require(:pedido_responsabilidade).permit(:id_laboratorio, :id_docente)
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

    def get_solicitador_responsabilidade
      @solicitador_responsabilidade = User.find(@pedido_responsabilidade.id_docente)
    end

    def permissao_existente
      @permissao_existente = (@solicitador_responsabilidade ==  @user || admin_signed_in?)
    end

    def permissao_novo
      @permissao_novo = (docente_signed_in? || admin_signed_in?)
    end

end
