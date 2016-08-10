class API::V1::EventsController < API::V1::ApiController
  load_resource

  def index
    filterrific = initialize_filterrific(
      Event,
      params[:filterrific]
    ) or return
    events = filterrific.find.page(params[:page])

    render json: events, status: :ok
  end

  def create
    event = Event.new event_params

    respond_to do |format|
      if event.save
        render json: event, status: :created, location: event
      else
        render json: event.errors, status: :unprocessable_entity
      end
    end
  end

  def update
    if @event.update event_params
      render json: @event, status: :ok
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @event.destroy
    head :no_content
  end

  def show
    render json: @event, status: :ok
  end

  private

  def event_params
    params.require(:event).permit(:title, :description, :finalized_date)
  end

end
