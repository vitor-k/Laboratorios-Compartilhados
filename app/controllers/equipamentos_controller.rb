class EquipamentosController < ApplicationController
  before_action :get_laboratorio
  before_action :set_equipamento, only: [:show, :edit, :update, :destroy]
  before_action :get_user
  before_action :get_responsavel

  # GET /equipamentos
  # GET /equipamentos.json
  def index
    # @equipamentos = Equipamento.all
    @equipamentos = @laboratorio.equipamentos
  end

  # GET /equipamentos/1
  # GET /equipamentos/1.json
  def show
  end

  # GET /equipamentos/new
  def new
    # @equipamento = Equipamento.new
    @equipamento = @laboratorio.equipamentos.build
  end

  # GET /equipamentos/1/edit
  def edit
  end

  # POST /equipamentos
  # POST /equipamentos.json
  def create
    if (admin_signed_in? || @user == @responsavel)
    # @equipamento = Equipamento.new(equipamento_params)
      @equipamento = @laboratorio.equipamentos.build(equipamento_params)
      respond_to do |format|
        if @equipamento.save
          format.html { redirect_to laboratorio_equipamentos_url(@laboratorio), notice: 'Equipamento was successfully created.' }
          format.json { render :show, status: :created, location: @equipamento }
        else
          format.html { render :new }
          format.json { render json: @equipamento.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to laboratorio_equipamentos_url(@laboratorio), notice: 'Não tem permissão para criar.' }
        format.json { head :no_content }
      end
    end
  end

  # PATCH/PUT /equipamentos/1
  # PATCH/PUT /equipamentos/1.json
  def update
    if (admin_signed_in? || @user == @responsavel)
      respond_to do |format|
        if @equipamento.update(equipamento_params)
          format.html { redirect_to laboratorio_equipamentos_url(@laboratorio), notice: 'Equipamento was successfully updated.' }
          format.json { render :show, status: :ok, location: @equipamento }
        else
          format.html { render :edit }
          format.json { render json: @equipamento.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to laboratorio_equipamentos_url(@laboratorio), notice: 'Não tem permissão para editar. ' }
        format.json { head :no_content }
      end
    end
  end

  # DELETE /equipamentos/1
  # DELETE /equipamentos/1.json
  def destroy
    if (admin_signed_in? || @user == @responsavel)
      @equipamento.destroy
      respond_to do |format|
        format.html { redirect_to laboratorio_equipamentos_url(@laboratorio), notice: 'Equipamento was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to laboratorio_equipamentos_url(@laboratorio), notice: 'Não tem permissão para deletar.' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_equipamento
      #@equipamento = Equipamento.find(params[:id])
      @equipamento = @laboratorio.equipamentos.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def equipamento_params
      params.require(:equipamento).permit(:nome, :funcao, :taxa, :laboratorio_id)
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
