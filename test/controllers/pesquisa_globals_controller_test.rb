require 'test_helper'

class PesquisaGlobalsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @laboratorio = create(:laboratorio)
  end
  

  test "should get index" do
    get pesquisa_global_url, params:{"utf8"=>"✓", "termo"=>"#{@laboratorio.nome}", 
      "laboratorio"=>"1", "equipamento"=>"0", "servico"=>"0", "postagem"=>"0"}
    assert_response :success
  end

end
