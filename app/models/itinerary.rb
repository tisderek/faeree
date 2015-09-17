class Itinerary < ActiveRecord::Base

  LONG_FORM_WEEKDAYS = {
    "Sun" => "Sunday",
    "Mon" => "Monday",
    "Tue" => "Tuesday",
    "Wed" => "Wednesday",
    "Thu" => "Thursday",
    "Fri" => "Friday",
    "Sat" => "Saturday"
  }

  LONG_FORM_ADDRESSES = {
    "ST" => "Street",
    "AVE" => "Avenue",
    "DR" => "Drive",
    "BLVD" => "Boulevard",
    "RD" => "Road",
    "CT" => "Court",
    "TER" => "Terrace",
    "ALY" => "Alley",
    "PL" => "Place"
  }

  before_create :replace_abbreviated_address, :replace_abbreviated_weekday

  # before_create callbacks

  def replace_abbreviated_address
    name_array = self.streetname.split(" ")
    # inde_of_type = name_array.find_index()
    name_array << LONG_FORM_ADDRESSES[name_array[-1]]
    name_array.delete_at(-2)
    self.streetname = name_array.join(" ")
    # delete below after making format_address
    self.streetname = self.streetname.titlecase
  end

  # def format_address
  #   address = self.streetname
  #   if address.first.is_a? Integer
  #     address_array = adress.split(" ")

  #   else
  #     self.streetname = address.titlecase

  #   end
  # end

  def replace_abbreviated_weekday
    self.weekday = LONG_FORM_WEEKDAYS[self.weekday]
  end
  
  def date_of_next(day)
    date  = Date.parse(day)
    delta = date >= Date.today ? 0 : 7
    date + delta
  end

  def make_time_obj
    d = date_of_next(self.weekday)
    t = self.fromhour
    s = DateTime.new(
      d.year, d.month, d.day, t.hour, t.min, t.sec, '-8'
      )
  end

  def parked_num_and_lowest_match?(parked)
    self.get_lowest_street_number.even? == parked.street_number.even?
  end

  def get_lowest_street_number
    a =[self.lf_fadd, self.lf_toadd, self.rt_fadd, self.rt_toadd].min
  end

  def lowest_num_and_cnn_match?
    a = [self.lf_fadd, self.lf_toadd, self.rt_fadd, self.rt_toadd]
    if a.index(a.min) == (0 || 1)
      col_of_lowest = "L"
    else
      col_of_lowest = "R"
    end
    col_of_lowest == self.cnnrightle
  end
end

