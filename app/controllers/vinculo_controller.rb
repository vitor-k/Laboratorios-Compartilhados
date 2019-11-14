class VinculoController < ApplicationController
  before_action :set_laboratorio
  before_action :get_user
  before_action :get_responsavel
  def index
  end

  def new
  end

  def create
    nomecompleto = params[:nomeCompleto]
    nusp = params[:nUSP]
    puts(params)

    if (Docente.where(nusp: nusp, user: User.where(nome: nomecompleto)).exists?)
      membro = Docente.find_by(nusp: nusp, user: User.where(nome: nomecompleto))      
    elsif (Aluno.where(nusp: nusp, user: User.where(nome: nomecompleto)).exists?)
      membro = Aluno.find_by(nusp: nusp, user: User.where(nome: nomecompleto))      
    else
      membro = nil
    end 

    puts membro

    if (membro == nil)
      respond_to do |format|
        format.html { redirect_to laboratorio_vinculo_index_path(@laboratorio), notice: 'Não foi possível criar vínculo' }
        format.json { head :no_content }
      end
    elsif (membro.user.aluno? && membro.laboratorio == nil)
      membro.update(laboratorio_id: @laboratorio.id)
      respond_to do |format|
        format.html { redirect_to laboratorio_vinculo_index_path(@laboratorio), notice: 'Criado com sucesso' }
        format.json { head :no_content }
      end
    elsif (membro.user.docente? && !@laboratorio.docentes.exists?(membro.id))
      @laboratorio.docentes << membro
      respond_to do |format|
        format.html { redirect_to laboratorio_vinculo_index_path(@laboratorio), notice: 'Criado com sucesso' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to laboratorio_vinculo_index_path(@laboratorio), notice: 'Não foi possível criar vínculo' }
        format.json { head :no_content }
      end
    end
  end

  def update
    nomecompleto = params[:nomeCompleto]
    nusp = params[:nUSP]

    if (Docente.where(nusp: nusp, user: User.where(nome: nomecompleto)).exists?)
      membro = Docente.find_by(nusp: nusp, user: User.where(nome: nomecompleto))      
    elsif (Aluno.where(nusp: nusp, user: User.where(nome: nomecompleto)).exists?)
      membro = Aluno.find_by(nusp: nusp, user: User.where(nome: nomecompleto))      
    else
      membro = nil
    end 

    if (membro == nil)
      respond_to do |format|
        format.html { redirect_to laboratorio_vinculo_index_path(@laboratorio), notice: 'Não foi possível remover vínculo' }
        format.json { head :no_content }
      end
    elsif (membro.user.docente? && membro.responsavel?(@laboratorio))
      respond_to do |format|
        format.html { redirect_to laboratorio_vinculo_index_path(@laboratorio), notice: 'Não se pode remover o vínculo do responsável' }
        format.json { head :no_content }
      end
    elsif (membro.user.docente?)
      @laboratorio.docentes.delete(membro)
      membro.update(laboratorio_id: nil)
      respond_to do |format|
        format.html { redirect_to laboratorio_vinculo_index_path(@laboratorio), notice: 'Vinculo removido com sucesso' }
        format.json { head :no_content }
      end
    else
      membro.update(laboratorio_id: nil)
      respond_to do |format|
        format.html { redirect_to laboratorio_vinculo_index_path(@laboratorio), notice: 'Vinculo removido com sucesso' }
        format.json { head :no_content }
      end
    end
  end

  private

    def set_laboratorio
      @laboratorio = Laboratorio.find(params[:laboratorio_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def laboratorio_params
      params.require(:laboratorio).permit(:laboratorio_id, :nome, :localizacao, :descricao, :responsavel_id)
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

    #get responsável
    def get_responsavel
      if (@laboratorio.responsavel_id != nil)
        @responsavel = Docente.find(@laboratorio.responsavel_id)
      else
        @responsavel = "sem_responsavel"
      end
    end

end
