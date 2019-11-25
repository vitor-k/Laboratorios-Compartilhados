require 'test_helper'

class PedidosControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @pedido = create(:pedido)

    @aluno_user = create(:user, :aluno)

    @equipamento = create(:equipamento)
    @servico = create(:servico)

    sign_in @aluno_user
  end

  teardown do
    sign_out @aluno_user
  end

  test "should get index" do
    get pedidos_url
    assert_response :success
  end

  test "should get new" do
    get new_pedido_url
    assert_response :success
  end

  test "should create pedido servico" do
    assert_difference('Pedido.count') do
      post pedidos_url, params: { 
        pedido: {
          data_inicio:  FFaker::Time.datetime( {:year_latest => -5, :year_range => 1}), 
          data_fim: FFaker::Time.datetime( {:year_latest => -7, :year_range => 1}),
          descricao: @pedido.descricao, 
          servico_id: @servico.id,
        }, 
        tipo: "servico"
      }
    end

    assert_redirected_to pedido_url(Pedido.last)
  end

  test "should create pedido equipamento" do
    assert_difference('Pedido.count') do
      post pedidos_url, params: { 
        pedido: {
          data_inicio:  FFaker::Time.datetime( {:year_latest => -9, :year_range => 1}), 
          data_fim: FFaker::Time.datetime( {:year_latest => -11, :year_range => 1}),
          descricao: @pedido.descricao, 
          equipamento_id: @equipamento.id,
        } ,
        tipo: "equipamento"
      }
    end

    assert_redirected_to pedido_url(Pedido.last)
  end

  test "should show pedido" do
    get pedido_url(@pedido)
    assert_response :success
  end

  test "should get edit" do
    get edit_pedido_url(@pedido)
    assert_response :success
  end

  test "should update pedido" do
    patch pedido_url(@pedido), params: { pedido: { data_fim: @pedido.data_fim, data_inicio: @pedido.data_inicio, descricao: @pedido.descricao, user_id: @aluno_user.id } }
    assert_redirected_to pedido_url(@pedido)
  end

  test "should destroy pedido" do
    solicitador = User.find(@pedido.user_id)
    sign_out @aluno_user
    sign_in solicitador
    assert_difference('Pedido.count', -1) do
      delete pedido_url(@pedido)
    end

    assert_redirected_to index_user_url(solicitador)

    sign_out solicitador
    sign_in @aluno_user
  end
end
