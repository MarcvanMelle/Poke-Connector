require 'rails_helper'

feature "Pokemon index" do
  context "Visitor navigates to pokemon index" do
    scenario "and sees all available pokemon" do
      visit pokemons_path

      pokemons = Pokemon.all

      pokemons.each do |pokemon|
        expect(page.find("#poke#{pokemon.id}")).to have_content("#{pokemon.pokedex_id}: #{pokemon.name}")
      end
    end
  end
end
