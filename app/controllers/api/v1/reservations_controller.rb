class API::V1::ReservationsController < API::V1::ApiController
  load_resource

  def index
    filterrific = initialize_filterrific(
      Reservation,
      params[:filterrific]
    ) or return
    reservations = filterrific.find.page(params[:page])

    render json: reservations, status: :ok
  end

  def create
    reservation = Reservation.new reservation_params
    reservation.user.profile = 'customer'

    if reservation.save
      render json: reservation, status: :created, location: reservation
    else
      render json: reservation.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: @reservation, status: :ok
  end

  def destroy
    @product.destroy
    head :no_content
  end

  private

  def reservation_params
    params.require(:reservation).permit(:occation, :reserved_at, :message, user_attributes: [:first_name, :last_name, :email])
  end
end
