class Event < Item

  def dine_in_spots
    self.spots.where(:spot_type=>"dine in").first.spot_count - self.rsvps.where(:rsvp_type=>'dine in').sum(:rsvp_count)
  end

  def take_out_spots
    if self.spots.where(:spot_type=>"take out").present?
      self.spots.where(:spot_type=>"take out").first.spot_count - self.rsvps.where(:rsvp_type=>'take out').sum(:rsvp_count)
    else
      return 0
    end
  end

end