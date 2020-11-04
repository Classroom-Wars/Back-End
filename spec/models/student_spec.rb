# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Student do
  describe 'Validations' do
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
    it { should validate_presence_of :provider }
    it { should validate_presence_of :uid }
    it { should validate_uniqueness_of :uid }
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
    it { should validate_presence_of :token }
    it { should validate_presence_of :refresh_token }
  end
end
