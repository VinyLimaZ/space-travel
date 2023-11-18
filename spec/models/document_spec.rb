# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Document, type: :model do
  it { should belong_to(:documentable) }
  it { should have_one_attached(:file) }
end
