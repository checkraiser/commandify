class Api::<%= options[:version].upcase %>::<%= file_name.camelize %>Serializer < ApplicationSerializer
  attributes <%= kreaders %>
end