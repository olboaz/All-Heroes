class User < ApplicationRecord
  has_many :heroes, through: :users_heroes
  has_one_attached :photo
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :username, :first_name, :last_name, :email, presence: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  after_create :send_welcome_email
  after_create :subscribe_to_newsletter

  private

  def subscribe_to_newsletter
    SubscribeToNewsletterService.new(self).call
  end

  def send_welcome_email
    UserMailer.with(user: self).welcome.deliver_now
  end

end
