require_relative 'seed_helper'

i = 1
721.times do
  pokedata = populate_pokemon(i)
  typeA = pokedata["types"][0]["type"]["name"]
  typeB = nil
  typeB = pokedata["types"][1]["type"]["name"] if pokedata["types"][1]
  Pokemon.create(name: pokedata["name"].capitalize, sprite: "#{pokedata["name"]}.gif", pokedex_id: i, typeA: typeA, typeB: typeB)
  i += 1
end
