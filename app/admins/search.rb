module Admins
  class Search < Search
    base_scope do
      if current_user.operator?
        Models::Admin.all
      elsif current_user.admin?
        Models::Admin.where(id: current_user.id)
      else
        Models::Admin.none
      end
    end

    query_by(:admin_id) { |admin_id| scope.where(id: admin_id) }
  end
end
