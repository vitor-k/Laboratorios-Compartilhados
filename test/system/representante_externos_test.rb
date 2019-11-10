require "application_system_test_case"

class RepresentanteExternosTest < ApplicationSystemTestCase
  setup do
    @representante_externo = representante_externos(:one)
  end

  test "visiting the index" do
    visit representante_externos_url
    assert_selector "h1", text: "Representante Externos"
  end

  test "creating a Representante externo" do
    visit representante_externos_url
    click_on "New Representante Externo"

    fill_in "Rg", with: @representante_externo.RG
    fill_in "Uf", with: @representante_externo.UF
    click_on "Create Representante externo"

    assert_text "Representante externo was successfully created"
    click_on "Back"
  end

  test "updating a Representante externo" do
    visit representante_externos_url
    click_on "Edit", match: :first

    fill_in "Rg", with: @representante_externo.RG
    fill_in "Uf", with: @representante_externo.UF
    click_on "Update Representante externo"

    assert_text "Representante externo was successfully updated"
    click_on "Back"
  end

  test "destroying a Representante externo" do
    visit representante_externos_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Representante externo was successfully destroyed"
  end
end
