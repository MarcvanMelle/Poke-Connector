require "rails_helper"

RSpec.describe AcceptMailer, type: :mailer do
  describe 'instructions' do
    let!(:usera) { FactoryGirl.create(:user) }
    let!(:userb) { FactoryGirl.create(:user, username: "PewterGym22") }
    let!(:pokemon) { Pokemon.create(name: "Bulbasaur", sprite: "bulbasaur.gif", pokedex_id: 1, typeA: "poison", typeB: "grass") }
    let!(:request) { Request.create(user: usera, pokemon: pokemon, description: "A real good pokemon.", created_at: DateTime.now - 15) }
    let!(:active) { ActiveRequest.create(user: userb, request: request) }
    let!(:mail) { AcceptMailer.accept_notification(usera, userb).deliver_now }

    it 'renders the subject' do
      expect(mail.subject).to eq('Your trade request was accepted!')
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
