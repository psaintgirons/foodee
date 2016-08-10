class Ability
  include CanCan::Ability

  def initialize(user)
    return false unless user

    if user.is_administrator?
      can [:index, :new, :create, :edit, :update, :destroy, :show, :report], Event
      can [:index, :new, :create, :edit, :update, :destroy, :show, :report], Product
      can [:index, :new, :create, :destroy, :show], User
      can [:edit, :update], User, id: user.id
      can [:index, :show, :destroy, :report], Reservation
    end

    if user.is_waiter?
      can [:index, :show], Reservation
    end

    if user.is_customer?
    end
  end
end
