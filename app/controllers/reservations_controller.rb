class ReservationsController < ApplicationController
  load_and_authorize_resource except: :create

  def index
    @filterrific = initialize_filterrific(
      Reservation,
      params[:filterrific]
    ) or return
    @reservations = @filterrific.find.page(params[:page])

    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @reservation = Reservation.new reservation_params
    @reservation.user.profile = 'customer'
    @reservation.save

    respond_to do |format|
      format.js
    end
  end

  def show
  end

  def destroy
    respond_to do |format|
      if @reservation.destroy
        format.html { redirect_to reservations_url, notice: "The reservation was destroyed successfully." }
      end
    end
  end

  def report
    reservations = Reservation.all
    pdf = ReservationsPdf.new(reservations)
    send_data pdf.render, filename: "reservations_#{Time.zone.now}.pdf", type: 'application/pdf', disposition: 'inline'
  end

  private

  def reservation_params
    params.require(:reservation).permit(:occation, :reserved_at, :message, user_attributes: [:first_name, :last_name, :email])
  end

end