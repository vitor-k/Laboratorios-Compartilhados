require 'test_helper'

class RepresentanteExternosControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @user = create(:user, :representante_externo)
    @representante_externo = RepresentanteExterno.find(@user.meta_id)

    @admin_user = create(:user, :admin)

    #puts param
    sign_in @user
  end

  teardown do
    sign_out @user
  end

  test "should get index if admin" do
    sign_out @user
    sign_in @admin_user
    get representante_externos_url
    assert_response :success
    sign_out @admin_user
    sign_in @user
  end

  test "should get new if logged out" do
    sign_out @user
    get new_representante_externo_url
    assert_response :success
    sign_in @user
  end

  test "should get new if logged in as admin" do
    sign_out @user
    sign_in @admin_user
    get new_representante_externo_url
    assert_response :success
    sign_out @admin_user
    sign_in @user
  end

  test "should not get new if logged in and not admin" do
    get new_representante_externo_url
    assert_redirected_to representante_externos_url
  end

  test "should not create representante_externo when not admin" do
    assert_no_difference('RepresentanteExterno.count') do
      post representante_externos_url, params: { representante_externo: { RG: @representante_externo.RG, UF: @representante_externo.UF } }
    end

    assert_redirected_to representante_externos_url
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
