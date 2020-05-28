class User < ApplicationRecord
  has_many :heroes, dependent: :destroy, class_name: 'Heroe'
  has_many :reviews
  has_many :likes, dependent: :destroy
  has_one_attached :photo

  validates :email,
  :presence => :true,
  :format => {
    :with => /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i,
    :message => "format d'email non valide"
  }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  #validates :first_name, :last_name, :email, presence: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  devise :omniauthable, omniauth_providers: [:facebook, :github, :google_oauth2]

  after_create :send_welcome_email
  after_create :subscribe_to_newsletter

  def self.find_for_facebook_oauth(auth)
    user_params = auth.slice("provider", "uid")
    user_params.merge! auth.info.slice("email", "first_name", "last_name")
    user_params[:facebook_picture_url] = auth.info.image
    user_params[:token] = auth.credentials.token
    user_params[:token_expiry] = Time.at(auth.credentials.expires_at)
    user_params = user_params.to_h
    user = User.find_by(provider: auth.provider, uid: auth.uid)
    user ||= User.find_by(email: auth.info.email) # User did a regular sign up in the past.
    if user
      user.update(user_params)
    else
      user = User.new(user_params)
      user.password = Devise.friendly_token[0,20]  # Fake password for validation
      user.save
    end

    return user
  end

  # def self.from_omniauth(auth)
  #   where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
  #     user.email = auth.info.email
  #     user.token = auth.credentials.token
  #     user.token_expiry = Time.at(auth.credentials.expires_at)
  #     user.password = Devise.friendly_token[0, 20]
  #     user.username = auth.info.name   # assuming the user model has a name
  #     user.photo = auth.info.image # assuming the user model has an image
  #     # If you are using confirmable and the provider(s) you use validate emails,
  #     # uncomment the line below to skip the confirmation emails.
  #     # user.skip_confirmation!
  #   end
  # end

  def self.create_from_provider_data(provider_data)
    where(provider: provider_data.provider, uid: provider_data.uid).first_or_create do |user|
      user.email = provider_data.info.email
      user.first_name = provider_data.info.name
      user.last_name = provider_data.info.name
      user.token = provider_data.credentials.token
      user.password = Devise.friendly_token[0, 20]
    end

  end


  # def self.new_with_session(params, session)
  #   super.tap do |user|
  #     if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
  #       user.email = data["email"] if user.email.blank?
  #     end
  #   end
  # end

  private

  def subscribe_to_newsletter
    SubscribeToNewsletterService.new(self).call
  end

  def send_welcome_email
    UserMailer.with(user: self).welcome.deliver_now
  end

end
