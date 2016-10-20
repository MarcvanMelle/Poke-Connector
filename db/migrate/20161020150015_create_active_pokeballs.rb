class CreateActivePokeballs < ActiveRecord::Migration[5.0]
  def change
    create_table :active_pokeballs do |t|
      t.belongs_to :user, null: false
      t.belongs_to :pokeball, null: false

      t.timestamps null: false
    end
  end
end
