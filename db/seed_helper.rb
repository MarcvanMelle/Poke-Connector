require 'HTTParty'

def populate_pokemon(id)
  pokedata = HTTParty.get("http://pokeapi.co/api/v2/pokemon/#{id}")
end
