require 'spec_helper'
describe 'wds' do
  context 'with default values for all parameters' do
    it { should contain_class('wds') }
  end
end
