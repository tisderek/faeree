class EventsController < ApplicationController
  include SessionsHelper
  include EventsHelper


  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
      if @event.save
        redirect_to @event, notice: 'User was successfully created.'
      else
        redirect_to 'show'
      end
  end

  def show
    @event = Event.find(params[:id])
    if @event.get_route == nil
      redirect_to 'dashboard'
      # erb :"parking_events/404", locals: { header: "Whoops" }
    else
      render 'show'
    end
  end

  def delete
  end

  def destroy
  end

  def notify
    @event = Event.find(params[:id])
    user.send_sms(
        "faeree: Make sure to move your vehicle before #{@event.get_route.strftime("%A at %-l:%M%P")}"
      )
  end

  private

    def set_event
      @event = User.find(params[:id])
    end

    def event_params
      params[:event]
    end
end
