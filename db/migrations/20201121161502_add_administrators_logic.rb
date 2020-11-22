class AddAdministratorsLogic < ActiveRecord::Migration[5.2]
  def change
    # Create administratos table in system
    create_table :admins do |t|
      t.string :email, null: false
      t.string :phone
      t.string :first_name
      t.string :last_name
      t.string :password_digest, null: false

      t.timestamps
    end

    add_index :admins, :email, unique: true, name: :admins_email_key
  end
end
