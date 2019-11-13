require 'test_helper'

class VinculoControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get vinculo_index_url
    assert_response :success
  end

  test "should get new" do
    get vinculo_new_url
    assert_response :success
  end

  test "should get create" do
    get vinculo_create_url
    assert_response :success
  end

  test "should get destroy" do
    get vinculo_destroy_url
    assert_response :success
  end

end
