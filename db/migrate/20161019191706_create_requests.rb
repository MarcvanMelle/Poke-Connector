class CreateRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :requests do |t|
      t.belongs_to :user, null: false
      t.belongs_to :pokemon, null: false
      t.text :decription

      t.timestamps
    end
  end
end
