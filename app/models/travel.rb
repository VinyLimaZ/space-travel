# frozen_string_literal: true

class Travel < ApplicationRecord
  belongs_to :planet
  belongs_to :spacecraft
  has_many :document, as: :documentable
  has_many :image, as: :imageable

  validates :duration, numericality: { only_integer: true }
  validates :status, state_transition: true

  enum status: {
    scheduled: 0,
    started: 1,
    aborted: 2,
    failed: 3,
    finished: 4
  }, _default: 0

  def initial_state
    ['scheduled']
  end

  def middle_state
    %w[started aborted]
  end

  def middle_state?
    status.in?(middle_state)
  end

  def final_state
    %w[aborted failed finished]
  end

  def final_state?
    status.in?(final_state)
  end
end
