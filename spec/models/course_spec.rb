require 'rails_helper'

RSpec.describe Course do
  describe 'Validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :course_code}
    it {should validate_presence_of :school_name}
  end

  describe 'Relationships' do
    it {should belong_to :teacher}
  end
end
