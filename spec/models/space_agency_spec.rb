require 'rails_helper'

RSpec.describe SpaceAgency, type: :model do
  it { should validate_presence_of(:name) }
end
