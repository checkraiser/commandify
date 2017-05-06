require 'rails_helper'

describe Api::<%= options[:version].upcase %>::<%= file_name.camelize %>Command do
  subject(:context) { described_class.call(<%= "#{file_name}_params" %>) }
  
  describe '.call' do    
    context 'when the context is successful' do
      let(<%= ":#{file_name}_params" %>) do
    
      end

      it 'succeeds' do
        expect(context).to be_success
      end
    end

    context 'when the context is not successful' do
      let(<%= ":#{file_name}_params" %>) do
    
      end

      it 'fails' do
        expect(context).to be_failure
      end
    end
  end
end