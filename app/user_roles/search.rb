module UserRoles
  class Search < Search
    base_scope do
      if current_user.operator?
        Models::UserRole.all
      elsif current_user.admin?
        Models::UserRole.inactive.joins(:role).where(roles: { code: 'seller' })
      else
        Models::UserRole.none
      end
    end

    query_by(:user_id) { |user_id| scope.where(user_id: user_id) }
    query_by(:user_role_id) { |user_role_id| scope.where(id: user_role_id) }
  end
end
