require 'test_helper'

class DocentesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @docente_user = create(:user, :docente)
    @docente = Docente.find(@docente_user.meta_id)
    
    @admin_user = create(:user, :admin)

    sign_in @docente.user
  end

  teardown do
    sign_out @docente.user
  end

  test "should get index if admin" do
    sign_out @docente_user
    sign_in @admin_user
    get docentes_url
    assert_response :success
    sign_out @admin_user
    sign_in @docente_user
  end

  test "should get new if admin" do
    sign_out @docente_user
    sign_in @admin_user
    get new_docente_url
    assert_response :success
    sign_out @admin_user
    sign_in @docente_user
  end

  test "should not create docente when logged in" do
    assert_no_difference('Docente.count') do
      post docentes_url, params: { docente: { departamento: @docente.departamento, nusp: @docente.nusp } }
    end

    assert_redirected_to docentes_url
  end

  test "should show docente" do
    get docente_url(@docente)
    assert_response :success
  end

  test "should get edit" do
    get edit_docente_url(@docente)
    assert_response :success
  end

  test "should update docente" do
    patch docente_url(@docente), params: { docente: { departamento: @docente.departamento, nusp: @docente.nusp } }
    assert_redirected_to docente_url(@docente)
  end

  test "should destroy docente" do
    assert_difference('Docente.count', -1) do
      delete docente_url(@docente)
    end

    assert_redirected_to docentes_url
  end
end
