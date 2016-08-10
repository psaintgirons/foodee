class Product < ActiveRecord::Base

  TYPES = { dish: 1, drink: 2 }
  CATEGORIES = ["Starters", "Pizza or Calzone", "Pasta", "Salads & Mains", "Dessert", "Cocktails", "Prosecco", "White Wine", "Red Wine", "Beers", "Spirits/Liquors"]

  validates :name, :product_type, :category, presence: true
  validates :description, presence: true, if: -> { product_type == TYPES[:dish] }
  validates :price, numericality: { greater_than: 0.0 }

  scope :with_name,     ->(name) { where('LOWER(name) LIKE ?', "%#{name.downcase}%") }
  scope :with_type,     ->(type) { where(product_type: type) }
  scope :with_category, ->(category) { where(category: category) }
  scope :featured_dishes, -> { where(product_type: TYPES[:dish]).limit(6).order("RAND()") }
  scope :to_menu, -> (type) { with_category(type).limit(4).order("RAND()") }
  scope :drinks, -> { to_menu('Cocktails') }
  scope :mains, -> { to_menu('Salads & Mains') }
  scope :desserts, -> { to_menu('Dessert') }
  scope :starters, -> { to_menu('Starters') }

  filterrific(
    available_filters: [
      :with_name,
      :with_type,
      :with_category
    ]
  )

  def display_type
    Product::TYPES.invert[self.product_type]
  end

end
