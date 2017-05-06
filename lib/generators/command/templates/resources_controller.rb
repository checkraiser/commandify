class Api::<%= options[:version].upcase %>::<%= resource.camelize.pluralize %>Controller < Api::V1::ApplicationController

  private

end