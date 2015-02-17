class Recurrence < ActiveRecord::Base

  belongs_to :item

  after_save :create_occurrences

  validates :recurrence_type, :inclusion => { :in => ['day', 'week', 'other week', 'month', 'day_of_x_week'] }

  def recurrence_increment
    increments = {'day' => 1.day, 'week' => 7.days, 'other week' => 14.days, 'month' => 1.month}
    @increment ||= increments[recurrence_type]
  end

  private
  def reduce_endpoint
    self.recurrence_type = 'day' if self.recurrence_type.nil?
    if self.recur_until.nil?
      self.recur_until = self.end_datetime
    end
    iter = self.end_datetime
    while iter + recurrence_increment <= self.recur_until
      iter += recurrence_increment
    end
    self.recur_until = iter
  end

  def create_occurrences
    o = Occurrence.create(:item_id => self.item_id, :dt => self.start_datetime)
    case self.recurrence_type
      when 'day'
        for i in 1..45
          if (self.start_datetime + i.days) < self.recur_until
            o = Occurrence.create(:item_id => self.item_id, :dt => self.start_datetime + i.days)
          end
        end
      when 'week'
        for i in 1..12
          if (self.start_datetime + i.weeks) < self.recur_until
            o = Occurrence.create(:item_id => self.item_id, :dt => self.start_datetime + i.weeks)
          end
        end
    end
  end

end