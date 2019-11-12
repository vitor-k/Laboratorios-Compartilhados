require 'test_helper'


class AdminsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    # @admin = admins(:admin1)
    @admin = create(:admin_user)
    
    puts(@admin.attributes)
    puts(@admin)
    # puts(@admin.user.attributes)
    sign_in @admin.user
  end

  teardown do
    sign_out(@admin.user)
  end

  test "should get index" do
    get admins_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_url
    assert_response :success
  end

  test "should create admin" do
    assert_difference('Admin.count') do
      post admins_url, params: { admin: { nusp: @admin.nusp, user_attributes: {
        nome: @admin.user.nome, email: "new_#{@admin.user.email}", password: @admin.user.encrypted_password,
        password_confirmation: @admin.user.encrypted_password
      } } }
    end

    assert_redirected_to admin_url(Admin.last)
  end

  test "should show admin" do
    get admin_url(@admin)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_url(@admin)
    assert_response :success
  end

  test "should update admin" do
    patch admin_url(@admin), params: { admin: { nusp: @admin.nusp } }
    assert_redirected_to admin_url(@admin)
  end

  test "should destroy admin" do
    assert_difference('Admin.count', -1) do
      delete admin_url(@admin)
    end

    assert_redirected_to admins_url
  end
end
