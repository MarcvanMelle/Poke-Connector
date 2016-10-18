class CreatePokemon < ActiveRecord::Migration[5.0]
  def change
    create_table :pokemons do |t|
      t.string :name, null: false
      t.string :sprite, null: false
      t.integer :pokedex_id, null: false
      t.string :typeA, null: false
      t.string :typeB
    end
  end
end
