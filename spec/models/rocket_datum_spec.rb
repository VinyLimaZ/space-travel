require 'rails_helper'

RSpec.describe RocketDatum, type: :model do
  it { should belong_to(:rocket).inverse_of(:rocket_datum).dependent(:destroy) }
  it { should belong_to(:payload) }
end
