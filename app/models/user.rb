class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook, :twitter]
  has_many :lotteries, through: :tickets
  has_many :tickets
  belongs_to :company
  validates_presence_of :company, message: "invalid"

  def winner_tickets
    self.tickets.where(won: true).joins(:lottery).order("start_date DESC")
  end

  def participated_lotteries
    self.lotteries.order("start_date DESC").uniq
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.first_name = auth.info.first_name # assuming the user model has a firstname
      user.last_name = auth.info.last_name # assuming the user model has a last name
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      key = nil
      if session["devise.facebook_data"]
        key = "devise.facebook_data"

        user.email = session[key]["info"]["email"] if user.email.blank?
        user.first_name = session[key]["info"]["first_name"] if user.first_name.blank?
        user.last_name = session[key]["info"]["last_name"] if user.last_name.blank?

      elsif session["devise.twitter_uid"]
        key = "devise.twitter_uid"

        name = session[key]["info"]["name"].split(" ")
        user.first_name = name[0] if user.first_name.blank?
        user.last_name = name[1] if user.last_name.blank?
      end

      if key
        user.provider = session[key]["provider"] if user.provider.blank?
        user.uid = session[key]["uid"] if user.uid.blank?
      end
    end
  end


end
