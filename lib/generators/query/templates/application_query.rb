class ApplicationQuery
  def render
    @query.execute.map(&:symbolize_keys) if @query
  end

  def explain
    @query.explain
  end

  def sql
    @query.sql
  end
end