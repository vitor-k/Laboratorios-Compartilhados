class ServicosController < ApplicationController
  before_action :get_laboratorio
  before_action :set_servico, only: [:show, :edit, :update, :destroy]
  before_action :get_user
  before_action :get_responsavel

  # GET /servicos
  # GET /servicos.json
  def index
    #@servicos = Servico.all
    @servicos = @laboratorio.servicos
  end

  # GET /servicos/1
  # GET /servicos/1.json
  def show
  end

  # GET /servicos/new
  def new
    #@servico = Servico.new
    @servico = @laboratorio.servicos.build
  end

  # GET /servicos/1/edit
  def edit
  end

  # POST /servicos
  # POST /servicos.json
  def create
    if (admin_signed_in? || @user == @responsavel)
      #@servico = Servico.new(servico_params)
      @servico = @laboratorio.servicos.build(servico_params)
      respond_to do |format|
        if @servico.save
          format.html { redirect_to laboratorio_servicos_url(@laboratorio), notice: 'Servico was successfully created.' }
          format.json { render :show, status: :created, location: @servico }
        else
          format.html { render :new }
          format.json { render json: @servico.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to laboratorio_servicos_url(@laboratorio), notice: 'Não tem permissão para criar.' }
        format.json { head :no_content }
      end
    end
  end

  # PATCH/PUT /servicos/1
  # PATCH/PUT /servicos/1.json
  def update
    if (admin_signed_in? || @user == @responsavel)
      respond_to do |format|
        if @servico.update(servico_params)
          format.html { redirect_to laboratorio_servicos_url(@laboratorio), notice: 'Servico was successfully updated.' }
          format.json { render :show, status: :ok, location: @servico }
        else
          format.html { render :edit }
          format.json { render json: @servico.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to laboratorio_servicos_url(@laboratorio), notice: 'Não tem permissão para editar.' }
        format.json { head :no_content }
      end
    end
  end

  # DELETE /servicos/1
  # DELETE /servicos/1.json
  def destroy
    if (admin_signed_in? || @user == @responsavel)
      @servico.destroy
      respond_to do |format|
        format.html { redirect_to laboratorio_servicos_url(@laboratorio), notice: 'Servico was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to laboratorio_servicos_url(@laboratorio), notice: 'Não tem permissão para destruir.' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_servico
      # @servico = Servico.find(params[:id])
      @servico = @laboratorio.servicos.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def servico_params
      params.require(:servico).permit(:nome, :descricao, :taxa, :laboratorio_id)
    end

    def get_laboratorio
      @laboratorio = Laboratorio.find(params[:laboratorio_id])
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

    def get_responsavel
      if (@laboratorio.responsavel_id != nil)
        @responsavel = Docente.find(@laboratorio.responsavel_id)
      else
        @responsavel = "sem_responsavel"
      end
    end
end
