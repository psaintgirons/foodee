class Event < ActiveRecord::Base

  validates :title, :description, :finalized_date, presence: true

  scope :with_title,    -> (title) { where('LOWER(title) LIKE ?', "%#{title.downcase}%") }
  scope :with_date_gte, -> (date) { where("finalized_date >= ?", Date.parse(date).beginning_of_day) }
  scope :with_date_lte, -> (date) { where("finalized_date <= ?", Date.parse(date).end_of_day)       }
  scope :next_events,   -> { with_date_gte(Time.zone.today.to_s).limit(3) }

  filterrific(
    available_filters: [
      :with_title,
      :with_date_gte,
      :with_date_lte
    ]
  )

end
