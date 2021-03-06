require 'spec_helper'

describe "custom_field#create" do
  before { sign_in }

  context "Create Custom Field" do
    it "success" do
      click_link "Configurar campos personalizados"
      click_link "Adicionar campo personalizado"
      fill_in "custom_field_title", with: "RG"
      find("option[value='text']").click
      click_button "Criar"
      expect(page).to have_content("Campo personalizado adicionado com sucesso.")
      within ".custom-field-title" do
        expect(page).to have_content("RG")
      end
    end
  end

end