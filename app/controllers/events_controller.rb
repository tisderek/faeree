class EventsController < ApplicationController
  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @event = Event.find(params[:id])
    if @event.get_route == nil
      # erb :"parking_events/404", locals: { header: "Whoops" }
    else
      # erb :"parking_events/show", locals: { parked: @event,  header: "Here's the 411" }
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
end
