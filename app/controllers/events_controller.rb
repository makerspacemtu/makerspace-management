class EventsController < ApplicationController
  load_and_authorize_resource

  def index
    @upcoming_events = {}
    @past_events = {}
    i = 1
    j = 1
    Event.all.each do |event|
      if event.event_end.to_i < Time.now.to_i
        @past_events[i] = event
        i += 1
      elsif event.event_end.to_i > Time.now.to_i
        @upcoming_events[j] = event
        j += 1
      end
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
    @users = User.where(user_type: ['Admin', 'Staff']).order(first_name: :asc)
  end

  def create
    @event = Event.new(event_params)

    if @event.save
      redirect_to events_path, notice: 'Event Created.'
    else
      render 'new'
    end
  end

  def destroy
    @event = Event.find(params[:id])

    if @event.destroy
      redirect_to events_path, notice: 'Event deleted.'
    else
      render 'edit', error: @event.errors
    end
  end

  def show
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])

    if @event.update(event_params)
      redirect_to events_path, notice: 'Event updated.'
    else
      render 'edit'
    end
  end

private

  def event_params
    params.require(:event).permit(:name, :desc, :event_start, :event_end, :org_name, :org_contact_name, :audience )
  end
end
