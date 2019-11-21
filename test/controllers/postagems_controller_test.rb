require 'test_helper'

class PostagemsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @postagem = postagems(:one)

    @aluno_user = users(:user_aluno1)
    @aluno = alunos(:aluno1)

    sign_in @aluno_user
  end

  teardown do
    sign_out @aluno_user
  end

  test "should get index" do
    get postagems_url
    assert_response :success
  end

  test "should get new" do
    get new_postagem_url
    assert_response :success
  end

  test "should create postagem" do
    assert_difference('Postagem.count') do
      post postagems_url, params: { postagem: { texto: @postagem.texto } }
    end

    assert_redirected_to postagem_url(Postagem.last)
  end

  test "should show postagem" do
    get postagem_url(@postagem)
    assert_response :success
  end

  test "should get edit" do
    get edit_postagem_url(@postagem)
    assert_response :success
  end

  test "should update postagem" do
    patch postagem_url(@postagem), params: { postagem: { texto: @postagem.texto } }
    assert_redirected_to postagem_url(@postagem)
  end

  test "should destroy postagem" do
    assert_difference('Postagem.count', -1) do
      delete postagem_url(@postagem)
    end

    assert_redirected_to postagems_url
  end
end
