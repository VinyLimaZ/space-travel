require 'rails_helper'

RSpec.describe Rocket, type: :model do
  it { should have_one(:rocket_datum) }
  it { should have_one(:payload).through(:rocket_datum) }
  it { should have_many(:document) }
end
