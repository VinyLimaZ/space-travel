require 'rails_helper'

RSpec.describe SpaceShuttleDatum, type: :model do
  it { should belong_to(:space_shuttle).inverse_of(:space_shuttle_datum).dependent(:destroy) }
  it { should validate_numericality_of(:max_crew_size).only_integer }
end
