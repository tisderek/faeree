class EventsController < ApplicationController
  include SessionsHelper
  include EventsHelper

  Geokit::Geocoders::GoogleGeocoder.api_key = 'AIzaSyB-4WojvjIigSwVn04P-0zv3I233tDKfPA'

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.user_id = user.id
      if @event.save
        redirect_to event_path(@event.id)
        #'user/#{user.id}/events/#{@event.id}'
      else
        redirect_to 'dashboard'
      end
  end

  def show
    @event = Event.find(params[:id])

    render 'show'
  end

  def delete
  end

  def destroy
  end

  def send_info_text
    p params
    @event = Event.find(params[:id])
    @event.send_sms(
        "faeree: You've parked by #{self.streetnumber} #{self.streetname}, and you should move before #{format_address(self.get_route)}"
    )
  end

  private

    def set_event
      @event = User.find(params[:id])
    end

    def event_params
      params.require(:event).permit(:lat, :lng)
    end
end
