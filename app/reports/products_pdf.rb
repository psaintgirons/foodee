require "prawn/table"
class ProductsPdf < Prawn::Document

  def initialize(products)
    super(top_margin: 20, page_layout: :landscape, print_scaling: :none)
    repeat :all do
      text "Products Report", align: :center, font_style: :italic
      stroke_horizontal_rule
    end
    move_down 30
    render_content products
  end

  def render_content products
    table products_rows(products), header: true, position: :center do
      cells.border_widu = 0
      rows(0).style size: 10
      rows(0).inline_format = true
      rows(0).padding_top = 25
    end
  end

  def products_rows products
    headers = [['<u>Name</u>', '<u>Description</u>', '<u>Type</u>', '<u>Price($)</u>', '<u>Category</u>']]
    rows    = []
    products.map do |product|
      rows << [
        product.name.titleize,
        product.description,
        product.display_type.to_s.titleize,
        product.price,
        product.category
      ]
    end
    headers + rows
  end
end
