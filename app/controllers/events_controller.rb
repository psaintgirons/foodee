class EventsController < ApplicationController
  load_and_authorize_resource

  def index
    @filterrific = initialize_filterrific(
      Event,
      params[:filterrific]
    ) or return
    @events = @filterrific.find.page(params[:page])

    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new event_params

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: "The event #{@event.title} was created successfully." }
      else
        format.html { render :new }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @event.update event_params
        format.html { redirect_to @event, notice: "The event #{@event.title} was updated successfully." }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @event.destroy
        format.html { redirect_to events_url, notice: "The event #{@event.title} was destroyed successfully." }
      end
    end
  end

  def show
  end

  def report
    events = Event.all
    pdf = EventsPdf.new(events)
    send_data pdf.render, filename: "events_#{Time.zone.now}.pdf", type: 'application/pdf', disposition: 'inline'
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :finalized_date)
  end

end
