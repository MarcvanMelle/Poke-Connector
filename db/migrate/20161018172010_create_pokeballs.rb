class CreatePokeballs < ActiveRecord::Migration[5.0]
  def change
    create_table :pokeballs do |t|
      t.belongs_to :user, null: false
      t.belongs_to :pokemon, null: false
      t.text :description
      t.integer :level
      t.integer :hpIV
      t.integer :attIV
      t.integer :defIV
      t.integer :spaIV
      t.integer :spdIV
      t.integer :speIV

      t.timestamps
    end
  end
end
