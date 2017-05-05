class <%= file_name.camelize %>Command
  prepend SimpleCommand
  include ActiveModel::Model

  validates :current_user, presence: true
  <% kv.each do |k, v| %>
  validates <%= ":#{k}" %> <%= ", presence: true" if v %>
  <%- end -%>

  def initialize(current_user:, <%= kinits %>)
    @current_user = current_user
    <%= declaration %>
  end

  def call
    return nil unless authorized?
    return nil unless valid?
    <%= file_name %>
  end
  

  private

  def authorized?
    true
  end

  def <%= file_name %>
    
  rescue => e
    errors.add <%= ":#{file_name}" %>, e.message
    nil
  end

  attr_reader :current_user, <%= kreaders %>
end
