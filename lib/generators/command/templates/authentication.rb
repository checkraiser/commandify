module Authentication
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_user
    attr_accessor :current_user
  end

  private

  def authenticate_user
    
  end
end
