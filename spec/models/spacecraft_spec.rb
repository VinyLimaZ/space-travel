require 'rails_helper'

RSpec.describe Spacecraft, type: :model do
  it { should belong_to(:space_agency) }
  it { should have_many(:travels) }
  it { should have_many(:document) }
  it { should have_many(:image) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:type) }
  it { should validate_numericality_of(:velocity).is_greater_than(0).only_integer }
  it { should validate_numericality_of(:fuel_in_days).only_integer }
end
