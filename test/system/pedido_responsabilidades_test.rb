require "application_system_test_case"

class PedidoResponsabilidadesTest < ApplicationSystemTestCase
  setup do
    @pedido_responsabilidade = pedido_responsabilidades(:one)
  end

  test "visiting the index" do
    visit pedido_responsabilidades_url
    assert_selector "h1", text: "Pedido Responsabilidades"
  end

  test "creating a Pedido responsabilidade" do
    visit pedido_responsabilidades_url
    click_on "New Pedido Responsabilidade"

    fill_in "Id docente", with: @pedido_responsabilidade.id_docente
    fill_in "Id laboratorio", with: @pedido_responsabilidade.id_laboratorio
    click_on "Create Pedido responsabilidade"

    assert_text "Pedido responsabilidade was successfully created"
    click_on "Back"
  end

  test "updating a Pedido responsabilidade" do
    visit pedido_responsabilidades_url
    click_on "Edit", match: :first

    fill_in "Id docente", with: @pedido_responsabilidade.id_docente
    fill_in "Id laboratorio", with: @pedido_responsabilidade.id_laboratorio
    click_on "Update Pedido responsabilidade"

    assert_text "Pedido responsabilidade was successfully updated"
    click_on "Back"
  end

  test "destroying a Pedido responsabilidade" do
    visit pedido_responsabilidades_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Pedido responsabilidade was successfully destroyed"
  end
end
