require 'rails_helper'

RSpec.describe UfoDatum, type: :model do
  it { should belong_to(:ufo).inverse_of(:ufo_datum).dependent(:destroy) }
  it { should have_many(:document) }
  it { should validate_numericality_of(:max_crew_size).only_integer }
end
