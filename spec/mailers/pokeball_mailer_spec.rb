require "rails_helper"

RSpec.describe PokeballMailer, type: :mailer do
  describe 'instructions' do
    let!(:usera) { FactoryGirl.create(:user) }
    let!(:userb) { FactoryGirl.create(:user, username: "PewterGym22") }
    let!(:pokemon) { Pokemon.create(name: "Bulbasaur", sprite: "bulbasaur.gif", pokedex_id: 1, typeA: "poison", typeB: "grass") }
    let!(:pokeball) { Pokeball.create(user: usera, pokemon: pokemon, level: 20, description: "A real good pokemon.") }
    let!(:mail) { PokeballMailer.pokeball_notification(usera, userb, pokeball).deliver_now }

    it 'renders the subject' do
      expect(mail.subject).to eq('You have a new trade request!')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq([usera.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eq(['noreply.pokeconnector@gmail.com'])
    end

    it 'assigns @name' do
      expect(mail.body.encoded).to match(usera.username)
    end
  end
end
