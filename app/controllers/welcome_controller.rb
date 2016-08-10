class WelcomeController < ApplicationController
  layout 'main'
  before_action :set_common_attributes

  def index
    @mains    = Product.mains
    @drinks   = Product.drinks
    @desserts = Product.desserts
    @starters = Product.starters
    @events   = Event.next_events
  end

  def menu
    @menu = Product.all.group_by(&:category)
  end

  private

  def set_common_attributes
    @featured_dishes = Product.featured_dishes
    @reservation = Reservation.new user: User.new
  end
end
