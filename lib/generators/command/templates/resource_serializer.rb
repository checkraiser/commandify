class API::<%= options[:version].upcase %>::<%= resource.camelize.pluralize %>Serializer < ApplicationSerializer
  attributes <%= kreaders %>
end