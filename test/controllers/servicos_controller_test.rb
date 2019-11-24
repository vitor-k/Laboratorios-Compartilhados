require 'test_helper'

class ServicosControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @laboratorio = create(:laboratorio)
    
    @servico = create(:servico, laboratorio_id: @laboratorio.id)
    
    @admin_user = create(:user, :admin)
    sign_in @admin_user

  end

  teardown do
    sign_out @admin_user
  end

  test "should get index" do
    get laboratorio_servicos_url(@laboratorio)
    assert_response :success
  end

  test "should get new" do
    get new_laboratorio_servico_url(@laboratorio)
    assert_response :success
  end

  test "should create servico" do
    assert_difference('Servico.count') do
      post laboratorio_servicos_url(@laboratorio), params: { servico: { descricao: @servico.descricao, nome: "new_#{@servico.nome}", taxa: @servico.taxa } }
    end

    assert_redirected_to laboratorio_servicos_url(@laboratorio)
  end

  test "should show servico" do
    get laboratorio_servico_url(@laboratorio, @servico)
    assert_response :success
  end

  test "should get edit" do
    get edit_laboratorio_servico_url(@laboratorio, @servico)
    assert_response :success
  end

  test "should update servico" do
    patch laboratorio_servico_url(@laboratorio, @servico), params: { servico: { descricao: @servico.descricao, nome: @servico.nome, taxa: @servico.taxa } }
    assert_redirected_to laboratorio_servicos_url(@laboratorio)
  end

  test "should destroy servico" do
    assert_difference('Servico.count', -1) do
      delete laboratorio_servico_url(@laboratorio, @servico)
    end

    assert_redirected_to laboratorio_servicos_url(@laboratorio)
  end
end
