require 'rails_helper'

RSpec.describe Planet, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_numericality_of(:earth_distance).is_greater_than(0).only_integer }
  end
end
