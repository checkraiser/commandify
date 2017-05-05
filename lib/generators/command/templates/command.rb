class <%= class_name %>Command
  prepend SimpleCommand
  include ActiveModel::Model

  <% kv.each do |k, v| %>
  validates <%= ":#{k}" %> <%= ", presence: true" if v %>
  <%- end -%>

  def initialize(<%= kinits %>)
    <%= declaration %>
  end

  def call
    return nil unless valid?
    <%= file_name %>
  end
  

  private

  def <%= file_name %>
    
  rescue => e
    errors.add <%= ":#{file_name}" %>, e.message
    nil
  end

  attr_reader <%= kreaders %>
end
