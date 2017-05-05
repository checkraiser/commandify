require 'rails_helper'

describe <%= class_name %> do
  subject(:context) { described_class.new(<%= "#{file_name}_params" %>).render }

end
