class Api::V1::ApplicationController < ApplicationController
  include Authentication
  include CommandHandler
end