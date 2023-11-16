require 'rails_helper'

RSpec.describe Travel, type: :model do
  context 'validations' do
    it { should belong_to(:planet) }
    it { should belong_to(:spacecraft) }
    it { should have_many(:document) }
    it { should have_many(:image) }
    it { should validate_numericality_of(:duration).only_integer }
    it { should define_enum_for(:status).with_values(scheduled: 0, started: 1, aborted: 2, failed: 3, finished: 4) }
  end
end
