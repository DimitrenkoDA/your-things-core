class AddShopsChanges < ActiveRecord::Migration[5.2]
  def change
    create_table :shops do |t|
      t.integer :user_id, null: false
      t.string :name, null: false
      t.text :description
      t.datetime :reviewed_at

      t.timestamps
    end

    add_index :shops, :user_id, unique: true, name: :shops_user_key
    add_foreign_key :shops, :users, column: :user_id, name: :shops_user_fkey
  end
end
