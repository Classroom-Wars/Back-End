require 'rails_helper'

RSpec.describe Student do
  describe 'Validations' do
    it {should validate_presence_of :name}
  end
end
