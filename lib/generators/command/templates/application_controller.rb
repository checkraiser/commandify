class Api::<%= options[:version].upcase %>::ApplicationController < ApplicationController
  include Authentication
  include Serializer
  include CommandHandler
end