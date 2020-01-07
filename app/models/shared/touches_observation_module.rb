module Shared::TouchesObservationModule
  def self.included(base)
    base.after_create  :touch_observation
    base.after_destroy :touch_observation
    base.attr_accessor :wait_for_obs_index_refresh
  end

  def touch_observation
    return unless observation
    return if observation.bulk_delete
    if respond_to?(:wait_for_obs_index_refresh) && wait_for_obs_index_refresh
      observation.wait_for_index_refresh = true
    end
    observation.touch
  end

end
