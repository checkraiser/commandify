require 'rails_helper'

describe <%= class_name %>Query do
  subject(:context) { described_class.new(<%= "#{file_name}_params.merge(current_user: current_user))" %>).render }
  
  let(:current_user) { }
  let(<%= ":#{file_name}_params" %>) { }
end
