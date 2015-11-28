module ItinerariesHelper

  def self.import
  end

  def runs_every_week?
    self.weeks_of_month == [1,2,3,4,5]
  end

  def weeks_of_month
    weeks_array = []
    weeks_array << 1 if self.week1ofmon
    weeks_array << 2 if self.week2ofmon
    weeks_array << 3 if self.week3ofmon
    weeks_array << 4 if self.week4ofmon
    weeks_array << 5 if self.week5ofmon
    weeks_array
  end

  def item_weekday
    self.weekday.downcase.to_sym
  end

  def create_weekly_schedule
    sched = IceCube::Schedule.new
    if itinerary.runs_every_week
      sched.add_recurrence_rule IceCube::Rule.weekly.day(on(itinerary.weekday))
    else
      sched.add_recurrence_rule IceCube::Rule.monthly.day_of_week(
        on(self.weekday) => f.weeks_of_month
      )
    end
  end

end