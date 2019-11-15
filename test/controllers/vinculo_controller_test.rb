require 'test_helper'

class VinculoControllerTest < ActionDispatch::IntegrationTest
  setup do
    @laboratorio = create(:laboratorio)
  end

  test "should get index" do
    get laboratorio_vinculo_index_url(@laboratorio)
    assert_response :success
  end

  test "should get new" do
    get new_laboratorio_vinculo_url(@laboratorio)
    assert_response :success
  end

  # test "should get create" do
  #   get laboratorio_vinculo_create_url(@laboratorio)
  #   assert_response :success
  # end

  # test "should get destroy" do
  #   get laboratorio_vinculo_destroy_url(@laboratorio)
  #   assert_response :success
  # end

end
