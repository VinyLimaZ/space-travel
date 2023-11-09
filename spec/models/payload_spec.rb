require 'rails_helper'

RSpec.describe Payload, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_numericality_of(:weight).only_integer }
  it { should allow_values(:sattelite, :probe, :trash_disposal, :fuel).for(:kind) }
end
