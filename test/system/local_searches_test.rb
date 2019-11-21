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

    fill_in 'Pesquisar serviço, equipamento ou postagem', with: ''
    click_button 'Pesquisar'

    # assert_redirected_to laboratorio_path(@laboratorio)
    assert_selector 'p', text: 'É preciso inserir um termo para pesquisar'
  end

  test 'pesquisa por um termo que tem e renderiza a página com o resultado' do
    visit laboratorio_path(@laboratorio)
    equipamento = create(:equipamento, laboratorio: @laboratorio)
    servico = create(:servico, laboratorio: @laboratorio)

    fill_in 'Pesquisar serviço, equipamento ou postagem', with: equipamento.nome
    click_button 'Pesquisar'

    #assert_redirected_to busca_laboratorio_path(@laboratorio)
    assert_selector 'td', text: equipamento.nome

    click_link 'Voltar'

    fill_in 'Pesquisar serviço, equipamento ou postagem', with: servico.nome
    click_button 'Pesquisar'

    assert_selector 'td', text: servico.nome
  end
end
