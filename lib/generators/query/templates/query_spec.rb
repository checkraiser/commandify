require 'rails_helper'

describe <%= class_name %> do
  subject(:context) { described_class.new(current_user: current_user, <%= "#{file_name}_params" %>).render }
  
  let(:current_user) { }
end
