require 'test_helper'

class PesquisaGlobalsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get pesquisa_globals_index_url
    assert_response :success
  end

end
