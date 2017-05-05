class <%= class_name %>Query < ApplicationQuery
  def initialize(<%= params %>)
    <%= params_declaration %>
    @query = SqlQuery.new(:<%= file_name %>_report, <%= params_assignment %>)
  end

  private

  attr_accessor <%= params_accessor %>
end