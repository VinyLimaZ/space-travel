# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Planet, type: :model do
  describe 'validations' do
    it { should have_many(:travels) }
    it { should have_many(:document) }
    it { should have_many(:image) }
    it { should validate_presence_of(:name) }
    it { should validate_numericality_of(:earth_distance).is_greater_than(0).only_integer }
  end
end
