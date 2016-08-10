require "prawn/table"
class EventsPdf < Prawn::Document

  def initialize(events)
    super(top_margin: 20, page_layout: :landscape, print_scaling: :none)
    repeat :all do
      text "Events Report", align: :center, font_style: :italic
      stroke_horizontal_rule
    end
    move_down 30
    render_content events
  end

  def render_content events
    table events_rows(events), header: true, position: :center do
      cells.border_widu = 0
      rows(0).style size: 10
      rows(0).inline_format = true
      rows(0).padding_top = 25
    end
  end

  def events_rows events
    headers = [['<u>Title</u>', '<u>Description</u>', '<u>Date</u>']]
    rows    = []
    events.map do |event|
      rows << [
        event.title.titleize,
        event.description,
        I18n.l(event.finalized_date)
      ]
    end
    headers + rows
  end
end
