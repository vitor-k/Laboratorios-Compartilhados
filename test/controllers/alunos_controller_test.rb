require 'test_helper'

class AlunosControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    # @aluno = alunos(:aluno1)
    # puts(@aluno.user.attributes)
    @aluno_user = create(:user, :aluno)
    @aluno = Aluno.find(@aluno_user.meta_id)

    sign_in @aluno.user
  end

  teardown do
    sign_out @aluno.user
  end

  test "should get index" do
    get alunos_url
    assert_response :success
  end

  test "should get new" do
    get new_aluno_url
    assert_response :success
  end

  test "should not create aluno when not admin" do
    assert_no_difference('Aluno.count') do
      post alunos_url, params: { aluno: { departamento: @aluno.departamento, nusp: @aluno.nusp,
        user_attributes: { nome: @aluno.user.nome, email: "new_#{@aluno.user.email}", 
          password: @aluno.user.encrypted_password,
          password_confirmation: @aluno.user.encrypted_password
        } } }
    end

    assert_redirected_to alunos_url
  end

  test "should create aluno when admin" do
    sign_out(@aluno.user)
    admin = admins(:admin1)
    sign_in(admin.user)
    assert_difference('Aluno.count') do
      post alunos_url, params: { aluno: { departamento: @aluno.departamento, nusp: @aluno.nusp,
        user_attributes: { nome: @aluno.user.nome, email: "new_#{@aluno.user.email}", 
          password: @aluno.user.encrypted_password,
          password_confirmation: @aluno.user.encrypted_password
        } } }
    end

    assert_redirected_to aluno_url(Aluno.last)
    sign_out(admin.user)
    sign_in(@aluno.user)
  end

  test "should create aluno when logged out" do
    sign_out(@aluno.user)
    assert_difference('Aluno.count') do
      post alunos_url, params: { aluno: { departamento: @aluno.departamento, nusp: @aluno.nusp,
        user_attributes: { nome: @aluno.user.nome, email: "new_#{@aluno.user.email}", 
          password: @aluno.user.encrypted_password,
          password_confirmation: @aluno.user.encrypted_password
        } } }
    end

    assert_redirected_to aluno_url(Aluno.last)
    sign_in(@aluno.user)
  end

  test "should show aluno" do
    get aluno_url(@aluno)
    assert_response :success
  end

  test "should get edit" do
    get edit_aluno_url(@aluno)
    assert_response :success
  end

  test "should update aluno" do
    patch aluno_url(@aluno), params: { aluno: { departamento: @aluno.departamento, nusp: @aluno.nusp } }
    assert_redirected_to aluno_url(@aluno)
  end

  test "should destroy aluno" do
    assert_difference('Aluno.count', -1) do
      delete aluno_url(@aluno)
    end

    assert_redirected_to alunos_url
  end
end
