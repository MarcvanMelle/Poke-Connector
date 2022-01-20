class AddGenderToPokeballs < ActiveRecord::Migration[5.1]
  def change
    add_column :pokeballs, :gender, :string, null: false
  end
end
