require 'test_helper'

class RepresentanteExternosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @representante_externo = representante_externos(:one)
  end

  test "should get index" do
    get representante_externos_url
    assert_response :success
  end

  test "should get new" do
    get new_representante_externo_url
    assert_response :success
  end

  test "should create representante_externo" do
    assert_difference('RepresentanteExterno.count') do
      post representante_externos_url, params: { representante_externo: { RG: @representante_externo.RG, UF: @representante_externo.UF } }
    end

    assert_redirected_to representante_externo_url(RepresentanteExterno.last)
  end

  test "should show representante_externo" do
    get representante_externo_url(@representante_externo)
    assert_response :success
  end

  test "should get edit" do
    get edit_representante_externo_url(@representante_externo)
    assert_response :success
  end

  test "should update representante_externo" do
    patch representante_externo_url(@representante_externo), params: { representante_externo: { RG: @representante_externo.RG, UF: @representante_externo.UF } }
    assert_redirected_to representante_externo_url(@representante_externo)
  end

  test "should destroy representante_externo" do
    assert_difference('RepresentanteExterno.count', -1) do
      delete representante_externo_url(@representante_externo)
    end

    assert_redirected_to representante_externos_url
  end
end
