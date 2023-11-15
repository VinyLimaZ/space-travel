require 'rails_helper'

RSpec.describe Image, type: :model do
  it { should belong_to(:imageable) }
  it { should have_one_attached(:file) }
end
