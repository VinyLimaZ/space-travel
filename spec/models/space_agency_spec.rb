require 'rails_helper'

RSpec.describe SpaceAgency, type: :model do
  it { should validate_presence_of(:name) }
  it { should have_many(:document) }
  it { should have_many(:image) }
end
