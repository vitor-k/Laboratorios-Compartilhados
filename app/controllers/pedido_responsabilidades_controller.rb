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
    if (PedidoResponsabilidade.where(id_docente: current_user.id).exists?) # procura se o docente tem pedidos de responsabilidade
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
    if (@permissao_novo) # se tem permissao para criar um novo pedido 
      @pedido_responsabilidade = PedidoResponsabilidade.new
    end
  end

  # GET /pedido_responsabilidades/1/edit
  def edit
  end

  # POST /pedido_responsabilidades
  # POST /pedido_responsabilidades.json
  def create
    @lab = pedido_responsabilidade_params[:id_laboratorio]
    @doc = current_user.id
    if (!@lab.empty?) #se tem laboratorio escolhido
      @pedido_responsabilidade = PedidoResponsabilidade.new(pedido_responsabilidade_params)
      if (@permissao_novo && pode_criar) #se tem permissão, o laboratorio n tem responsavel e não está em aberto
        @pedido_responsabilidade.id_docente = @doc
        respond_to do |format|
          if @pedido_responsabilidade.save
            format.html { redirect_to account_path, notice: 'Pedido responsabilidade was successfully created.' } 
            format.json { render :show, status: :created, location: @pedido_responsabilidade }
          else
            format.html { render :new }
            format.json { render json: @pedido_responsabilidade.errors, status: :unprocessable_entity }
          end
        end
      else #se não tem permissão ou laboratorio ja tem responsavel
        respond_to do |format|
          format.html { redirect_to new_pedido_responsabilidade_path, notice: 'Não foi possível solicitar responsabilidade.' }
          format.json { head :no_content }
        end
      end
    else #não tem laboratorio escolhido
      respond_to do |format|
        format.html { redirect_to new_pedido_responsabilidade_path, notice: 'Deve selecionar um laboratório.' }
        format.json { head :no_content }
      end
    end
  end

  # PATCH/PUT /pedido_responsabilidades/1
  # PATCH/PUT /pedido_responsabilidades/1.json
  def update    
    if (@permissao_existente && pode_alterar) #se tem permissao existente e é possível alterar para o que deseja
      if (admin_signed_in?)
        respond_to do |format|
          if @pedido_responsabilidade.update(pedido_responsabilidade_params)
            format.html { redirect_to pedido_responsabilidades_path, notice: 'Pedido responsabilidade was successfully updated.' }
            format.json { render :show, status: :ok, location: @pedido_responsabilidade }
          else
            format.html { render :edit }
            format.json { render json: @pedido_responsabilidade.errors, status: :unprocessable_entity }
          end
        end
      else
        respond_to do |format|
          if @pedido_responsabilidade.update(pedido_responsabilidade_params)
            format.html { redirect_to index_docente_path(current_user.id), notice: 'Pedido responsabilidade was successfully updated.' }
            format.json { render :show, status: :ok, location: @pedido_responsabilidade }
          else
            format.html { render :edit }
            format.json { render json: @pedido_responsabilidade.errors, status: :unprocessable_entity }
          end
        end
      end
    else
      if (admin_signed_in?)
        respond_to do |format|
          format.html { redirect_to pedido_responsabilidades_path, notice: 'Não foi possivel editar solicitação de responsabilidade.' }
          format.json { head :no_content }
        end
      else
        respond_to do |format|
          format.html { redirect_to index_docente_path(current_user.id), notice: 'Não foi possivel editar solicitação de responsabilidade.' }
          format.json { head :no_content }
        end
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
          format.html { redirect_to index_docente_path(current_user.id), notice: 'Solicitação de responsabilidade deletada.' }
          format.json { head :no_content }
        end
      end
    end
  end

  # PUT
  def aceitar
    if (admin_signed_in?)

      Laboratorio.find(@pedido_responsabilidade.id_laboratorio).update(responsavel_id: User.find(@pedido_responsabilidade.id_docente).meta_id) #Adiciona o docente como responsavel
      Laboratorio.find(@pedido_responsabilidade.id_laboratorio).docentes << Docente.find(User.find(@pedido_responsabilidade.id_docente).meta_id) #Adiciona o responsavel como membro

      @pedido_responsabilidades_afetados = PedidoResponsabilidade.where(id_laboratorio: @pedido_responsabilidade.id_laboratorio)
      @pedido_responsabilidades_afetados.find_each do |cada|
        cada.destroy
      end
      respond_to do |format|
        format.html { redirect_to pedido_responsabilidades_path, notice: 'Solicitação aceita.' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to root_path, notice: 'Não tem permissão.' }
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
      params.require(:pedido_responsabilidade).permit(:id_laboratorio, :id_docente, :justificativa)
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

    # pega o usuario que criou o pedido
    def get_solicitador_responsabilidade
      @solicitador_responsabilidade = User.find(@pedido_responsabilidade.id_docente)
    end

    # permissao para alterar um pedido existente
    def permissao_existente
      @permissao_existente = (@solicitador_responsabilidade ==  @user || admin_signed_in?)
    end

    # permissao para criar um novo pedido
    def permissao_novo
      @permissao_novo = (docente_signed_in? || admin_signed_in?)
    end

    # verifica se o laboratorio ja tem um responsavel e se ja tem um pedido do usuario para tal laboratorio
    def pode_criar
      @lab = pedido_responsabilidade_params[:id_laboratorio]
      @doc = current_user.id
      tem_responsavel = Laboratorio.find(@pedido_responsabilidade.id_laboratorio).responsavel == nil
      aberto = pedido_aberto_criar
      tem_responsavel && aberto == false
    end

    # verifica se pode criar um pedido analisando os pedidos já abertos
    def pedido_aberto_criar
      if !@lab.empty?
          if PedidoResponsabilidade.exists?(id_laboratorio: @lab, id_docente: @doc) # se um pedido para o laboratorio desse usuario ja existe, aberto = true
              true
          else # usuario nao tem pedido para esse lab
            false 
          end
      else # nao tem pedidos para esse lab
          false
      end
    end

    # verifica se o usuario pode alterar um pedido de responsabilidade existente
    def pode_alterar
      @lab = pedido_responsabilidade_params[:id_laboratorio]
      @doc = current_user.id
      tem_responsavel = Laboratorio.find(@lab).responsavel == nil # O outro laboratório não tem responsavel
      aberto = pedido_aberto_alterar
      tem_responsavel && aberto == false
    end

    # verifica se já há um pedido aberto sem ser esse
    def pedido_aberto_alterar
      if !@lab.empty?
          if PedidoResponsabilidade.exists?(id_laboratorio: @lab, id_docente: @doc) # se existe um pedido de responsabilidade do laboratorio desse docente
            if PedidoResponsabilidade.find_by(id_laboratorio: @lab, id_docente: @doc).id == @pedido_responsabilidade.id # se o pedido for esse pedido, pode alterar
              false
            else # se o pedido for outro pedido, ja esta aberto e nao pode alterar
              true
            end
          else # nao tem pedidos desse docente
            false 
          end
      else # nao tem nenhum pedido de responsabilidade para o laboratorio
          false
      end
    end
end
