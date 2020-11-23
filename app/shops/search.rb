module Shops
  class Search < Search
    base_scope do
      if current_user.operator?
        Models::Shop.all
      elsif current_user.admin?
        Models::Shop.unreviewed
      else
        Models::Shop.reviewed
      end
    end

    query_by(:shop_id) { |shop_id| scope.where(id: shop_id) }
  end
end
