require "prawn/table"
class ReservationsPdf < Prawn::Document

  def initialize(reservations)
    super(top_margin: 20, page_layout: :landscape, print_scaling: :none)
    repeat :all do
      text "Reservations Report", align: :center, font_style: :italic
      stroke_horizontal_rule
    end
    move_down 30
    render_content reservations
  end

  def render_content reservations
    table reservations_rows(reservations), header: true, position: :center do
      cells.border_widu = 0
      rows(0).style size: 10
      rows(0).inline_format = true
      rows(0).padding_top = 25
    end
  end

  def reservations_rows reservations
    headers = [['<u>Date</u>', '<u>Name</u>', '<u>Occation</u>', '<u>Message</u>']]
    rows    = []
    reservations.map do |reservation|
      rows << [
        I18n.l(reservation.reserved_at, format: :short),
        reservation.user.full_name,
        reservation.occation.titleize,
        reservation.message
      ]
    end
    headers + rows
  end
end
