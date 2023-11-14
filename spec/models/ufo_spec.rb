require 'rails_helper'

RSpec.describe Ufo, type: :model do
  it { should have_one(:ufo_datum) }
  it { should delegate_method(:max_crew_size).to(:ufo_datum).allow_nil }
end