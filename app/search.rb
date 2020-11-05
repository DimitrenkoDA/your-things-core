class Search < Parascope::Query
  def first
    resolved_scope.first
  end

  def one!
    resolved_scope.first!
  end

  def perform
    resolved_scope
  end

  def count
    resolved_scope.count
  end

  def exists?
    resolved_scope.exists?
  end
end
