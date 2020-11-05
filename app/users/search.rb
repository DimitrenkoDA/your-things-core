module Users
  class Search < Search
    base_scope do
      if current_user.operator?
        Models::User.all
      else
        Models::User.where(id: current_user.id)
      end
    end

    query_by(:user_id) { |user_id| scope.where(id: user_id) }
  end
end
