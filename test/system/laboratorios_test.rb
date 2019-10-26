require "application_system_test_case"

class LaboratoriosTest < ApplicationSystemTestCase
  setup do
    @laboratorio = laboratorios(:one)
  end

  test "visiting the index" do
    visit laboratorios_url
    assert_selector "h1", text: "Laboratorios"
  end

  test "creating a Laboratorio" do
    visit laboratorios_url
    click_on "New Laboratorio"

    fill_in "Descricao", with: @laboratorio.descricao
    fill_in "Localizacao", with: @laboratorio.localizacao
    fill_in "Nome", with: @laboratorio.nome
    click_on "Create Laboratorio"

    assert_text "Laboratorio was successfully created"
    click_on "Back"
  end

  test "updating a Laboratorio" do
    visit laboratorios_url
    click_on "Edit", match: :first

    fill_in "Descricao", with: @laboratorio.descricao
    fill_in "Localizacao", with: @laboratorio.localizacao
    fill_in "Nome", with: @laboratorio.nome
    click_on "Update Laboratorio"

    assert_text "Laboratorio was successfully updated"
    click_on "Back"
  end

  test "destroying a Laboratorio" do
    visit laboratorios_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Laboratorio was successfully destroyed"
  end
end
