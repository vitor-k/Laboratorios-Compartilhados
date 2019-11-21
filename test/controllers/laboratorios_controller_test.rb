require 'test_helper'

class LaboratoriosControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  require 'docentes_helper'
  setup do
    @laboratorio = create(:laboratorio)

    @responsavel = Docente.find(@laboratorio.responsavel_id)
    # @responsavel = create(:user, :docente)

    @admin_user = create(:user, :admin)
    @admin = Admin.find(@admin_user.meta_id)

    sign_in @admin.user

    # @admin = admins(:admin1)
    # @admin_user = users(:user_admin1)

    # sign_in @admin_user
  end

  teardown do
    sign_out @admin_user
  end

  test "should get index" do
    get laboratorios_url
    assert_response :success
  end

  test "should get new" do
    get new_laboratorio_url
    assert_response :success
  end

  test "should create laboratorio" do
    assert_difference('Laboratorio.count') do
      post laboratorios_url, params: { laboratorio: { descricao: @laboratorio.descricao, localizacao: @laboratorio.localizacao, nome: @laboratorio.nome, responsavel_id: @responsavel.id } }
    end

    assert_redirected_to laboratorio_url(Laboratorio.last)
  end

  test "should show laboratorio" do
    get laboratorio_url(@laboratorio)
    assert_response :success
  end

  test "should get edit" do
    get edit_laboratorio_url(@laboratorio)
    assert_response :success
  end

  test "should update laboratorio" do
    patch laboratorio_url(@laboratorio), params: { laboratorio: { descricao: @laboratorio.descricao, localizacao: @laboratorio.localizacao, nome: @laboratorio.nome, responsavel_id: @responsavel.id } }
    assert_redirected_to laboratorio_url(@laboratorio)
  end

  test "should destroy laboratorio" do
    assert_difference('Laboratorio.count', -1) do
      delete laboratorio_url(@laboratorio)
    end

    assert_redirected_to laboratorios_url
  end
end
