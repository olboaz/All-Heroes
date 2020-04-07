# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/welcome
  def welcome
    user = User.second
    # This is how you pass value to params[:user] inside mailer definition!
    UserMailer.with(user: user).welcome.deliver_now
  end

end