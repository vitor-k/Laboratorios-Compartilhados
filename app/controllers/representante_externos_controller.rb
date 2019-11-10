class RepresentanteExternosController < ApplicationController
  before_action :authenticate_user!, :authenticate_representante, except: [:new, :create, :update, :show]
  before_action :new_registration, only: [:new, :create]
  before_action :set_representante_externo, only: [:show, :edit, :update, :destroy]

  # GET /representante_externos
  # GET /representante_externos.json
  def index
    @representante_externos = RepresentanteExterno.all
  end

  # GET /representante_externos/1
  # GET /representante_externos/1.json
  def show
  end

  # GET /representante_externos/new
  def new
    @representante_externo = RepresentanteExterno.new
    @representante_externo.build_user
  end

  # GET /representante_externos/1/edit
  def edit
  end

  # POST /representante_externos
  # POST /representante_externos.json
  def create
    @representante_externo = RepresentanteExterno.new(representante_externo_params)

    respond_to do |format|
      if @representante_externo.save
        format.html do
          sign_in @representante_externo.user
          redirect_to @representante_externo, notice: 'Representante externo was successfully created.'
        end
        format.json { render :show, status: :created, location: @representante_externo }
      else
        format.html { render :new }
        format.json { render json: @representante_externo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /representante_externos/1
  # PATCH/PUT /representante_externos/1.json
  def update
    respond_to do |format|
      if @representante_externo.update(representante_externo_params)
        format.html do 
          sign_in @representante_externo.user
          redirect_to @representante_externo, notice: 'Representante externo was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @representante_externo }
      else
        format.html { render :edit }
        format.json { render json: @representante_externo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /representante_externos/1
  # DELETE /representante_externos/1.json
  def destroy
    @representante_externo.destroy
    respond_to do |format|
      format.html { redirect_to representante_externos_url, notice: 'Representante externo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_representante_externo
      @representante_externo = RepresentanteExterno.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def representante_externo_params
      params.require(:representante_externo).permit(:RG, :UF, user_attributes: [:id, :email, :password, :password_confirmation, :nome])
    end

    def authenticate_representante
      redirect_to(new_user_session_path) unless current_user.meta_type == 'RepresentanteExterno'
    end

    def new_registration
      redirect_to(representante_externos_path, alert: 'You can\'t create a new user while logged in') if user_signed_in? && !current_user.admin?
    end

end
