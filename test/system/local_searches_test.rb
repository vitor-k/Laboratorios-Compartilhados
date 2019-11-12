require "application_system_test_case"

class LocalSearchesTest < ApplicationSystemTestCase
  # test "visiting the index" do
  #   visit local_searches_url
  #
  #   assert_selector "h1", text: "LocalSearches"
  # end
  setup do
    @laboratorio = create(:laboratorio)
  end

  test "visitando o laboratório e encontrando a barra de pesquisa" do
    visit laboratorio_path(@laboratorio)

    assert_selector "input", id: "laboratorio_termo"
  end

  test 'pesquisa por um termo que não tem e redireciona de volta' do
    visit laboratorio_path(@laboratorio)

    #fill_in 'Pesquisar serviço, equipamento ou postagem', with: ''
    click_button 'Pesquisar'

    #assert_redirected_to laboratorio_path(@laboratorio)
    assert_selector 'p', text: 'Não há resultados com esse termo'
  end
end
