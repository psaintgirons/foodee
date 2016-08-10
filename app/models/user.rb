class User < ActiveRecord::Base

  PROFILES = %w[administrator waiter customer]

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :first_name, :last_name, :profile, presence: true

  before_create :set_auth_token, unless: -> { is_customer? }

  scope :with_first_name, -> (first_name) { where('LOWER(first_name) LIKE ?', "%#{first_name.downcase}%") }
  scope :with_last_name,  -> (last_name)  { where('LOWER(last_name) LIKE ?', "%#{last_name.downcase}%") }
  scope :with_profile,    -> (profile)    { where(profile: profile) }

  filterrific(
    available_filters: [
      :with_first_name,
      :with_last_name,
      :with_profile
    ]
  )

  PROFILES.each do |profile|
    define_method("is_#{profile}?") { self.profile == profile }
  end

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  private

  def password_required?
    self.is_customer? ? false : true
  end

  def set_auth_token
    return if auth_token.present?
    self.auth_token = generate_auth_token
  end

  def generate_auth_token
    loop do
      token = SecureRandom.hex
      break token unless self.class.exists?(auth_token: token)
    end
  end

end
