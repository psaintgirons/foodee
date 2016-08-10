module  ProductsHelper

  def product_types
    Product::TYPES.collect { |key, value| [key.to_s.titleize, value] }
  end

  def display_data product
    content_tag :div do
      content_tag(:h2, "#{product.name} / #{product.category}".titleize) + content_tag(:span, number_to_currency(product.price), class: 'pricing') + content_tag(:p, product.description)
    end
  end

  def menu_item item, truncate = false
    description = truncate ? truncate(item.description, length: 80) : item.description
    content_tag :li do
      content_tag(:div, content_tag(:div, content_tag(:h3, item.name.titleize) + content_tag(:p, description)), class: 'fh5co-food-desc') + content_tag(:div, number_to_currency(item.price), class: 'fh5co-food-pricing')
    end
  end

end
