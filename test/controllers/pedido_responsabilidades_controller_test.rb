require 'test_helper'

class PedidoResponsabilidadesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @laboratorio = create(:laboratorio, tem_responsavel: false)
    @pedido_responsabilidade = create(:pedido_responsabilidade, id_laboratorio: @laboratorio.id)

    @docente_user = create(:user, :docente)

    @admin_user = create(:user, :admin)

    sign_in @docente_user
  end

  teardown do
    sign_out @docente_user
  end

  test "should get index" do
    sign_out @docente_user
    sign_in @admin_user

    get pedido_responsabilidades_url
    assert_response :success

    sign_out @admin_user
    sign_in @docente_user
  end

  test "should get new" do
    get new_pedido_responsabilidade_url
    assert_response :success
  end

  test "should create pedido_responsabilidade" do
    laboratorio2 = create(:laboratorio, tem_responsavel: false)
    assert_difference('PedidoResponsabilidade.count') do
      post pedido_responsabilidades_url, params: { pedido_responsabilidade: { id_docente: @pedido_responsabilidade.id_docente, id_laboratorio: laboratorio2.id } }
    end

    assert_redirected_to account_url
  end

  test "should show pedido_responsabilidade" do
    get pedido_responsabilidade_url(@pedido_responsabilidade)
    assert_response :success
  end

  test "should get edit" do
    get edit_pedido_responsabilidade_url(@pedido_responsabilidade)
    assert_response :success
  end

  test "should update pedido_responsabilidade" do
    patch pedido_responsabilidade_url(@pedido_responsabilidade), params: { pedido_responsabilidade: { id_docente: @pedido_responsabilidade.id_docente, id_laboratorio: @pedido_responsabilidade.id_laboratorio } }
    assert_redirected_to account_url
  end

  test "should destroy pedido_responsabilidade" do
    assert_difference('PedidoResponsabilidade.count', -1) do
      delete pedido_responsabilidade_url(@pedido_responsabilidade)
    end

    assert_redirected_to account_url
  end
end
