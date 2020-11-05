class AddUsersAndRolesChanges < ActiveRecord::Migration[5.2]
  def change
    # Create users table
    create_table :users do |t|
      t.string :email, null: false
      t.string :first_name
      t.string :last_name
      t.string :password_digest, null: false

      t.timestamps
    end

    add_index :users, :email, unique: true, name: :users_email_key

    # Create roles table
    create_table :roles do |t|
      t.string :code, null: false
      t.string :title, null: false
    end

    add_index :roles, :code, unique: true, name: :roles_code_key

    # Create user_roles table
    create_table :user_roles do |t|
      t.integer :role_id, null: false
      t.integer :user_id, null: false

      t.timestamps
    end

    add_foreign_key :user_roles, :roles, column: :role_id, name: :roles_user_role_fkey
    add_foreign_key :user_roles, :users, column: :user_id, name: :users_user_role_fkey
  end
end
