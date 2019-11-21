class AlunosController < ApplicationController
  before_action :authenticate_user!, :authenticate_aluno, except: [:new, :create, :update, :show, :index]
  before_action :new_registration, only: [:create]
  before_action :set_aluno, only: [:show, :edit, :update, :destroy]

  # GET /alunos
  # GET /alunos.json
  def index
    if(!admin_signed_in?)
      redirect_back(fallback_location: root_path, notice: 'Acesso negado.')
    end
    @alunos = Aluno.all
  end

  # GET /alunos/1
  # GET /alunos/1.json
  def show
  end

  # GET /alunos/new
  def new
    @aluno = Aluno.new
    @aluno.build_user
  end

  # GET /alunos/1/edit
  def edit
  end

  # POST /alunos
  # POST /alunos.json
  def create
    @aluno = Aluno.new(aluno_params)

    respond_to do |format|
      if @aluno.save
        format.html do 
          sign_in(@aluno.user)
          redirect_to aluno_url(@aluno), notice: 'Aluno was successfully created.'
        end
        format.json { render :show, status: :created, location: @aluno }
      else
        format.html { render :new }
        format.json { render json: @aluno.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /alunos/1
  # PATCH/PUT /alunos/1.json
  def update
    respond_to do |format|
      if @aluno.update(aluno_params)
        format.html do 
          sign_in @aluno.user
          redirect_to @aluno, notice: 'Aluno was successfully updated.' 
        end
        format.json { render :show, status: :ok, location: @aluno }
      else
        format.html { render :edit }
        format.json { render json: @aluno.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /alunos/1
  # DELETE /alunos/1.json
  def destroy
    @aluno.destroy
    respond_to do |format|
      format.html { redirect_to alunos_url, notice: 'Aluno was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_aluno
      @aluno = Aluno.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def aluno_params
      params.require(:aluno).permit(:nusp, :departamento, :laboratorio_id, user_attributes: [:id, :email, :password, :password_confirmation, :nome])
    end

    def authenticate_aluno
      redirect_to(new_user_session_path) unless current_user.meta_type == 'Aluno'
    end

    def new_registration
      redirect_to(alunos_path) if user_signed_in? && !current_user.admin?
    end
end
