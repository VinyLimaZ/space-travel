class StateTransitionValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, _value)
    return unless record.will_save_change_to_status?

    validate_transition(record, attribute)
  end

  private

  def validate_transition(record, attribute)
    initial_state(record, attribute) if record.status_was.nil?
    blocked_transition(record, attribute) if record.status_was.in? record.final_state
    scheduled_transition(record, attribute) if record.status_was.in? record.initial_state
    started_transition(record, attribute) if record.status_was.in? record.middle_state
  end

  def initial_state(record, attribute)
    return if record.scheduled?

    initial_state_error_message(record, attribute)
  end

  def initial_state_error_message(record, attribute)
    record.errors.add(attribute, :wrong_start)
  end

  def scheduled_transition(record, attribute)
    return if record.errors.any?
    return if record.middle_state?

    scheduled_transition_error(record, attribute)
  end

  def scheduled_transition_error(record, attribute)
    record.errors.add(attribute, :wrong_middle_transition)
  end

  def started_transition(record, attribute)
    return if record.errors.any?
    return if record.final_state?

    started_transition_error(record, attribute)
  end

  def started_transition_error(record, attribute)
    record.errors.add(attribute, :wrong_final_transition)
  end

  def blocked_transition(record, attribute)
    return if record.errors.any?

    blocked_transition_error(record, attribute)
  end

  def blocked_transition_error(record, attribute)
    record.errors.add(attribute, :blocked_to_change)
  end
end
