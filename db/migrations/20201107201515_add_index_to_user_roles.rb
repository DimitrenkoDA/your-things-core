class AddIndexToUserRoles < ActiveRecord::Migration[5.2]
  def change
    # Prohibiting the creation of identical roles for user
    add_index :user_roles, %i[role_id user_id], unique: true, name: :user_roles_role_and_user_key

    # Add column activated_at to user_roles for seller logic
    add_column :user_roles, :activated_at, :datetime
  end
end
