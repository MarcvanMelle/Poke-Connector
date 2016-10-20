class CreateActiveRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :active_requests do |t|
      t.belongs_to :user, null: false
      t.belongs_to :request, null: false

      t.timestamps null: false
    end
  end
end
