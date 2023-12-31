# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Rocket, type: :model do
  it { should have_one(:rocket_datum) }
  it { should have_one(:payload).through(:rocket_datum) }
  it { should have_many(:document) }
  it { should have_many(:image) }
end
