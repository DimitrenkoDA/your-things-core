module Shops
  class Search < Search
    base_scope do
      Models::Shop.reviewed.all
    end

    query_by(:shop_id) { |shop_id| scope.where(id: shop_id) }
  end
end
