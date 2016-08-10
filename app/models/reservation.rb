class Reservation < ActiveRecord::Base

  OCCATIONS = ['Wedding Ceremony', 'Birthday', 'Others']

  belongs_to :user

  accepts_nested_attributes_for :user, allow_destroy: true

  validates :reserved_at, presence: true

  scope :with_reserved_at_gte, -> (date) { where("reserved_at >= ?", Date.parse(date).beginning_of_day) }
  scope :with_reserved_at_lte, -> (date) { where("reserved_at <= ?", Date.parse(date).end_of_day)       }
  scope :with_occation, -> (occation) { where(occation: occation) }

  filterrific(
    available_filters: [
      :with_reserved_at_gte,
      :with_reserved_at_lte,
      :with_occation
    ]
  )

end
