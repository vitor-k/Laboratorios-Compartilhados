require 'test_helper'

class PedidoResponsabilidadesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @pedido_responsabilidade = create(:pedido_responsabilidade)
  end

  test "should get index" do
    get pedido_responsabilidades_url
    assert_response :success
  end

  test "should get new" do
    get new_pedido_responsabilidade_url
    assert_response :success
  end

  test "should create pedido_responsabilidade" do
    assert_difference('PedidoResponsabilidade.count') do
      post pedido_responsabilidades_url, params: { pedido_responsabilidade: { id_docente: @pedido_responsabilidade.id_docente, id_laboratorio: @pedido_responsabilidade.id_laboratorio } }
    end

    assert_redirected_to pedido_responsabilidade_url(PedidoResponsabilidade.last)
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
    assert_redirected_to pedido_responsabilidade_url(@pedido_responsabilidade)
  end

  test "should destroy pedido_responsabilidade" do
    assert_difference('PedidoResponsabilidade.count', -1) do
      delete pedido_responsabilidade_url(@pedido_responsabilidade)
    end

    assert_redirected_to pedido_responsabilidades_url
  end
end
