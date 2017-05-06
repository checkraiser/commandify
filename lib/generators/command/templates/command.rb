class Api::<%= options[:version].upcase %>::<%= file_name.camelize %>Command
  prepend SimpleCommand
  include ActiveModel::Model

  <% kv.each do |k, v| %>
  validates <%= ":#{k}" %> <%= ", #{v}: true" if v %>
  <% end %>

  def initialize(options = { })
    @current_user = options[:current_user]
    <%= declaration %>
  rescue => e
    errors.add <%= ":#{file_name}" %>, e.message
    nil
  end

  def call
    return nil unless authorized?
    return nil unless valid?
    <%= file_name %>
  end
  
  attr_accessor :status

  private

  def authorized?
    true
  end

  def <%= file_name %>
    status = 200
  rescue => e
    errors.add <%= ":#{file_name}" %>, e.message
    nil
  end

  attr_reader :current_user, <%= kreaders %>
end
