class <%= class_name %>Query < ApplicationQuery
  def initialize(current_user:, <%= params %>)
    @current_user = current_user
    <%= params_declaration %>
    @query = SqlQuery.new(:<%= file_name %>_report, current_user: current_user, <%= params_assignment %>)
  end

  private

  attr_accessor :current_user, <%= params_accessor %>
end