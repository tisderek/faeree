class Itinerary < ActiveRecord::Base

  before_create :format_st_names, :format_weekdays

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
    "St" => "Street",
    "Ave" => "Avenue",
    "Dr" => "Drive",
    "Blvd" => "Boulevard",
    "Rd" => "Road",
    "Ct" => "Court",
    "Ter" => "Terrace",
    "Aly" => "Alley",
    "Pl" => "Place"
  }

  def format_weekdays
    self.weekday = LONG_FORM_WEEKDAYS[self.weekday]
  end

  def format_st_names
    self.streetname = self.streetname.titlecase
    if self.streetname.split(" ")[1] == "St"
      self.streetname = self.streetname.gsub("St", "Street")
    elsif self.streetname.split(" ")[1] == "Ave"
      self.streetname = self.streetname.gsub("Ave", "Avenue")
    elsif self.streetname.split(" ")[1] == "Dr"
      self.streetname = self.streetname.gsub("Dr", "Drive")
    elsif self.streetname.split(" ")[1] == "Blvd"
      self.streetname = self.streetname.gsub("Blvd", "Boulevard")
    elsif self.streetname.split(" ")[1] == "Rd"
      self.streetname = self.streetname.gsub("Rd", "Road")
      self.streetname = self.streetname.sub("Road", "rd")
    elsif self.streetname.split(" ")[1] == "Ct"
      self.streetname = self.streetname.gsub("Ct", "Court")
    elsif self.streetname.split(" ")[1] == "Ter"
      self.streetname = self.streetname.gsub("Ter", "Terrace")
    elsif self.streetname.split(" ")[1] == "Aly"
      self.streetname = self.streetname.gsub("Aly", "Alley")
    end

    if self.streetname.split("")[0] = "0"
      self.streetname = self.streetname.sub("0","")
      self.streetname = self.streetname.sub(" ","")
    end

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

