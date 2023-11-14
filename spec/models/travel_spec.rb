require 'rails_helper'

RSpec.describe Travel, type: :model do
  it { should belong_to(:planet) }
  it { should belong_to(:spacecraft) }
  it { should validate_numericality_of(:duration).only_integer }
  it { should define_enum_for(:status).with_values(schedule: 0, started: 1, aborted: 2, failed: 3, finished: 4) }
end
