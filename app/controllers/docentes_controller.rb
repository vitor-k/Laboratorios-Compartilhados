class DocentesController < ApplicationController
  before_action :authenticate_user!, :authenticate_docente, except: [:new, :create, :update, :show, :index]
  before_action :new_registration, only: [:new, :create]
  before_action :set_docente, only: [:show, :edit, :update, :destroy]

  # GET /docentes
  # GET /docentes.json
  def index
    if(!admin_signed_in?)
      redirect_back(fallback_location: root_path, notice: 'Acesso negado.')
    end
    @docentes = Docente.all
  end

  # GET /docentes/1
  # GET /docentes/1.json
  def show
  end

  # GET /docentes/new
  def new
    @docente = Docente.new
    @docente.build_user
  end

  # GET /docentes/1/edit
  def edit
  end

  # POST /docentes
  # POST /docentes.json
  def create
    @docente = Docente.new(docente_params)

    respond_to do |format|
      if @docente.save
        format.html do 
          sign_in @docente.user
          redirect_to @docente, notice: 'Docente was successfully created.' 
        end
        format.json { render :show, status: :created, location: @docente }
      else
        format.html { render :new }
        format.json { render json: @docente.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /docentes/1
  # PATCH/PUT /docentes/1.json
  def update
    respond_to do |format|
      if @docente.update(docente_params)
        format.html do 
          sign_in @docente.user
          redirect_to @docente, notice: 'Docente was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @docente }
      else
        format.html { render :edit }
        format.json { render json: @docente.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /docentes/1
  # DELETE /docentes/1.json
  def destroy
    @docente.destroy
    respond_to do |format|
      format.html { redirect_to docentes_url, notice: 'Docente was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_docente
      @docente = Docente.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def docente_params
      params.require(:docente).permit(:nusp, :departamento, user_attributes: [:id, :email, :password, :password_confirmation, :nome])
    end

    def authenticate_docente
      redirect_to(new_user_session_path) unless current_user.meta_type == 'Docente'
    end

    def new_registration
      redirect_to(docentes_path, alert: 'Você não pode criar um usuário estando logado') if user_signed_in? && !current_user.admin?
    end
end
