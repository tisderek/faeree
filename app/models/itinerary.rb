class Itinerary < ActiveRecord::Base

  LONG_FORM_WEEKDAYS = {
    "Sun" => "Sunday",
    "Mon" => "Monday",
    "Tues" => "Tuesday",
    "Wed" => "Wednesday",
    "Thu" => "Thursday",
    "Fri" => "Friday",
    "Sat" => "Saturday",
    "Holiday" => "Holiday"
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
    "PL" => "Place",
    "WAY" => "Way"
  }

  before_create :replace_abbreviated_address, :replace_abbreviated_weekday, :format_address

  # before_create callbacks

  def replace_abbreviated_address
    name_array = self.streetname.split(" ")
    # inde_of_type = name_array.find_index()
    name_array << LONG_FORM_ADDRESSES[name_array[-1]]
    name_array.delete_at(-2)
    self.streetname = name_array.join(" ")
    # delete below after making format_address
    # self.streetname = self.streetname.titlecase
  end

  def is_a_integer?(obj)
    obj.to_i.to_s == obj
  end

  def format_address
    address = self.streetname
    if is_a_integer?(address.first)
      address_array = address.split(" ")
      address_array[0].slice!(0) if address_array[0].first.to_i == 0
      number = address_array[0].downcase
      remainder = address_array[1..-1].join(" ").titlecase
      self.streetname = "#{number} #{remainder}"
    else
      self.streetname = address.titlecase
    end
  end

  def replace_abbreviated_weekday
    self.weekday = LONG_FORM_WEEKDAYS[self.weekday]
  end
  
  def date_of_next(day)
    binding.pry
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
  
  # refactor into a concern
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

