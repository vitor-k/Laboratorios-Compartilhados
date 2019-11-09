class LaboratoriosController < ApplicationController
  before_action :set_laboratorio, only: [:show, :edit, :update, :destroy, :laboratorio_equipamentos, :laboratorio_servicos]
  before_action :get_user, only: [:create, :show, :edit, :update, :destroy, :laboratorio_equipamentos, :laboratorio_servicos]
  before_action :getResponsavel, only: [:show, :edit, :update, :destroy, :laboratorio_equipamentos, :laboratorio_servicos]

  # GET /laboratorios
  # GET /laboratorios.json
  def index
    @laboratorios = Laboratorio.all
  end

  # GET /laboratorios/1
  # GET /laboratorios/1.json
  def show
  end

  #def showPaginaLab
  #end

  # GET /laboratorios/new
  def new
    if (admin_signed_in?)
      @laboratorio = Laboratorio.new
    end
  end

  def laboratorio_equipamentos
  end

  def laboratorio_servicos
  end

  # GET /laboratorios/1/edit
  def edit
  end

  # POST /laboratorios
  # POST /laboratorios.json
  def create
    @laboratorio = Laboratorio.new(laboratorio_params)
    respond_to do |format|
      if @laboratorio.save
        format.html { redirect_to @laboratorio, notice: 'Laboratorio was successfully created.' }
        format.json { render :show, status: :created, location: @laboratorio }
      else
        format.html { render :new }
        format.json { render json: @laboratorio.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /laboratorios/1
  # PATCH/PUT /laboratorios/1.json
  def update
    if (@user == @responsavel || admin_signed_in?)
    respond_to do |format|
      if @laboratorio.update(laboratorio_params)
        format.html { redirect_to @laboratorio, notice: 'Laboratorio was successfully updated.' }
        format.json { render :show, status: :ok, location: @laboratorio }
      else
        format.html { redirect_to laboratorios_url, notice: 'Sem permissão para editar laboratório.' }
        format.json { head :no_content }
      end
    end
    end
  end

  # DELETE /laboratorios/1
  # DELETE /laboratorios/1.json
  def destroy
    if (admin_signed_in?)
      @laboratorio.destroy
      respond_to do |format|
        format.html { redirect_to laboratorios_url, notice: 'Laboratorio was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to laboratorios_url, notice: 'Sem permissão para deletar laboratório.' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_laboratorio
      @laboratorio = Laboratorio.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def laboratorio_params
      params.require(:laboratorio).permit(:nome, :localizacao, :descricao, :responsavel_id)
    end

    # current user
    def get_user
      @user ||=
        if aluno_signed_in?
          id = current_aluno.id
          @user = Aluno.find(id)
        elsif representante_externo_signed_in?
          id = current_representante_externo.id
          @user = Representante_externo.find(id)
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

    #get responsável
    def getResponsavel
      @responsavel = Docente.find(@laboratorio.responsavel_id)
    end
end
