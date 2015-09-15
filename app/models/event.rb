class Event < ActiveRecord::Base
  include DateTimeHelper
  include Geokit

  validates :user_id, presence:true
  validates :street_name, presence:true
  validates :street_number, presence:true

  before_validation :reverse_geocode
  belongs_to  :user

  def reverse_geocode
    location = LatLng.new(self.lat, self.lng)
    self.street_number = location.reverse_geocode.street_number
    self.street_name = location.reverse_geocode.street_name
  end

  def add_route_to_parking_event
    self.next_sweep
  end

  def routes_by_street
    Route.where(streetname: self.street_name)
  end

  def ceiling_filter
    parked = self
    self.routes_by_street.to_a.select do |r|
        (  (r.lf_fadd <= parked.street_number) || (r.rt_fadd <= parked.street_number)  )
    end
  end

  def floor_filter
    parked = self
    self.ceiling_filter.select do |r|
        (  (r.lf_toadd >= parked.street_number) || (r.rt_toadd >= parked.street_number) )
    end
  end

  def side_filter
    parked = self
    self.floor_filter.select do |r|
      match_of_parked_num_and_lowest = r.parked_num_and_lowest_match?(parked)
      match_of_lowest_num_and_cnn = r.lowest_num_and_cnn_match?
      match_of_lowest_num_and_cnn == match_of_parked_num_and_lowest
    end
  end

  def get_route
    t = Time.new
    week_routes = []
    side_filter.each do |route|
      r = route.make_time_obj
      week_routes << r
    end
    week_routes.sort!.first
  end

  def send_sms(body_text)

    to_number = User.find(self.user_id).phone_number
    client = Twilio::REST::Client.new ENV["TWILIO_SID"], ENV["TWILIO_TOKEN"]
    from = '+14152341719'

    message = client.account.messages.create(
        from: from,
        to: to_number,
        body: body_text
      )
  end

end
