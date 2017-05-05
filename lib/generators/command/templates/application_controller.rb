class Api::V1::ApplicationController < ApplicationController
  include Authentication
  include Serializer
  include CommandHandler
end