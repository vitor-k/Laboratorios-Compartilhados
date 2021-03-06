class AdminsController < ApplicationController
  before_action :authenticate_user!, :authenticate_admin, except: [:new, :create, :update, :show, :index]
  before_action :new_registration, only: [:create]
  before_action :set_admin, only: [:show, :edit, :update, :destroy]

  # GET /admins
  # GET /admins.json
  def index
    if(!admin_signed_in?)
      redirect_back(fallback_location: root_path, notice: 'Acesso negado.')
    end
    @admins = Admin.all
  end

  # GET /admins/1
  # GET /admins/1.json
  def show
  end

  # GET /admins/new
  def new
    @admin = Admin.new
    @admin.build_user
  end

  # GET /admins/1/edit
  def edit
  end

  # POST /admins
  # POST /admins.json
  def create
    @admin = Admin.new(admin_params)

    respond_to do |format|
      if @admin.save
        format.html do 
          sign_in @admin.user
          redirect_to @admin, notice: 'Admin was successfully created.' 
        end
        format.json { render :show, status: :created, location: @admin }
      else
        format.html { render :new }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admins/1
  # PATCH/PUT /admins/1.json
  def update
    respond_to do |format|
      if @admin.update(admin_params)
        format.html do 
          sign_in @admin.user
          redirect_to @admin, notice: 'Admin was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @admin }
      else
        format.html { render :edit }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admins/1
  # DELETE /admins/1.json
  def destroy
    @admin.destroy
    respond_to do |format|
      format.html { redirect_to admins_url, notice: 'Admin was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin
      @admin = Admin.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_params
      params.require(:admin).permit(:nusp, user_attributes: [:id, :email, :password, :password_confirmation, :nome])
    end

    def authenticate_admin
      redirect_to(new_user_session_path) unless current_user.meta_type == 'Admin'
    end

    def new_registration
      redirect_to(root_path, alert: 'Only an admin can do that') if user_signed_in? && !current_user.admin?
    end

end
