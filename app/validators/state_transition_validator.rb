class StateTransitionValidator < ActiveModel::EachValidator
  def validate_each(record, _status_enum, _value)
    return unless record.will_save_change_to_status?

    validate_transition(record)
  end

  private

  def validate_transition(record)
    initial_state(record) if record.status_was.nil?
    blocked_transition(record) if record.status_was.in? record.final_state
    scheduled_transition(record) if record.status_was.in? record.initial_state
    started_transition(record) if record.status_was.in? record.middle_state
  end

  def initial_state(record)
    return if record.scheduled?

    initial_state_error_message(record)
  end

  def initial_state_error_message(record)
    record.errors.add :status, 'need to start with scheduled'
  end

  def scheduled_transition(record)
    return if record.errors.any?
    return if record.middle_state?

    scheduled_transition_error(record)
  end

  def scheduled_transition_error(record)
    record.errors.add :status, 'need to transit to started or aborted'
  end

  def started_transition(record)
    return if record.errors.any?
    return if record.final_state?

    started_transition_error(record)
  end

  def started_transition_error(record)
    record.errors.add :status, 'need to transit to aborted, failed or finished'
  end

  def blocked_transition(record)
    return if record.errors.any?

    blocked_transition_error(record)
  end

  def blocked_transition_error(record)
    record.errors.add :status, 'is in the final state and can\'t be changed! Please create another trip'
  end
end
