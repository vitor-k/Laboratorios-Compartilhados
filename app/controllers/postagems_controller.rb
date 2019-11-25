class PostagemsController < ApplicationController
  before_action :set_postagem, only: [:show, :edit, :update, :destroy]
  before_action :getPoster, only: [:show, :edit, :update, :destroy]
  before_action :get_user, only: [:edit, :create, :update, :destroy, :new]

  # GET /postagems
  # GET /postagems.json
  # padrão scaffold
  def index
    @postagems = Postagem.all
  end

  # GET /postagems/1
  # GET /postagems/1.json
  # padrão scaffold
  def show
  end

  # GET /postagems/new
  def new
    if (@user != nil)
      @postagem = Postagem.new
    end
  end

  # GET /postagems/1/edit
  def edit
  end

  # POST /postagems
  # POST /postagems.json
  def create
    @postagem = @user.user.postagems.build(postagem_params)
    if (admin_signed_in? || aluno_signed_in? || docente_signed_in? ) # se é admin ou aluno ou docente
      if (admin_signed_in?) #admin logado pode criar vazio
        respond_to do |format|
          if @postagem.save(postagem_params)
            format.html { redirect_to @postagem, notice: 'Postagem was successfully created.' }
            format.json { render :show, status: :created, location: @postagem }
          else
            format.html { render :new }
            format.json { render json: @postagem.errors, status: :unprocessable_entity }
          end
        end
      elsif (aluno_signed_in? && current_aluno.laboratorio_id != nil) #aluno não pode criar vazio
        respond_to do |format|
          if @postagem.save(postagem_params)
            format.html { redirect_to @postagem, notice: 'Postagem was successfully created.' }
            format.json { render :show, status: :created, location: @postagem }
          else
            format.html { render :new }
            format.json { render json: @postagem.errors, status: :unprocessable_entity }
          end
        end
      elsif (docente_signed_in? && !current_docente.laboratorios.empty?) #docente não pode criar vazio
        respond_to do |format|
          if @postagem.save(postagem_params)
            format.html { redirect_to @postagem, notice: 'Postagem was successfully created.' }
            format.json { render :show, status: :created, location: @postagem }
          else
            format.html { render :new }
            format.json { render json: @postagem.errors, status: :unprocessable_entity }
          end
        end
      else
        respond_to do |format|
          format.html { redirect_to new_postagem_url, notice: 'Não foi possível criar postagem.' }
          format.json { render :show, status: :created, location: @postagem }
        end
      end
    end
  end

  # PATCH/PUT /postagems/1
  # PATCH/PUT /postagems/1.json
  #update padrão do scaffold
  def update
    respond_to do |format|
      if @postagem.update(postagem_params)
        format.html { redirect_to @postagem, notice: 'Postagem was successfully updated.' }
        format.json { render :show, status: :ok, location: @postagem }
      else
        format.html { render :edit }
        format.json { render json: @postagem.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /postagems/1
  # DELETE /postagems/1.json
  def destroy
    if (eh_poster_membro || admin_signed_in? || eh_responsavel) # condições para poder deletar: é o poster e ainda é membro, é admin, é responsavel
      #@postagem.destroy
      respond_to do |format|
        format.html { redirect_to postagems_url, notice: 'Postagem was successfully destroyed.' }
        format.json { head :no_content }
      end
      else
        respond_to do |format|
        format.html { redirect_to postagems_url, notice: 'Você não tem permissão para deletar.' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_postagem
      @postagem = Postagem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def postagem_params
      puts(params)
      params.require(:postagem).permit(:texto,:titulo,:laboratorio_id)
    end

    # current user 
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

    # who created the post
    def getPoster
      poster_user = User.find(@postagem.user_id)
      if (poster_user.aluno?)
          @poster = Aluno.find(poster_user.meta_id)    
      elsif (poster_user.docente?)
          @poster = Docente.find(poster_user.meta_id)   
      elsif (poster_user.representante_externo?)
          @poster = RepresentanteExterno.find(poster_user.meta_id)
      elsif (poster_user.admin?)
          @poster = Admin.find(poster_user.meta_id)
      end
    end

    # o usuario é o poster e ainda é membro do laboratório
    def eh_poster_membro
      if (@user == @poster) # verifica se o user é o poster e se ele ainda está no laboratório
        if (aluno_signed_in?)
          true if (@user.laboratorio == @postagem.laboratorio)
        elsif (docente_signed_in?)
          true if (@user.laboratorios.exists?(@postagem.laboratorio.id))
        else
          false
        end
      else
        false
      end
    end

    # usuario é responsavel do laboratorio
    def eh_responsavel
      if (@user == @postagem.laboratorio.responsavel) # verifica se é o responsavel
        true
      else
        false
      end
    end
end
