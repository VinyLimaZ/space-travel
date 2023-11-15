require 'rails_helper'

RSpec.describe SpaceShuttle, type: :model do
  it { should have_one(:space_shuttle_datum) }
  it { should delegate_method(:max_crew_size).to(:space_shuttle_datum).allow_nil }
  it { should have_many(:document) }
end
