class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  include Pundit

  # Pundit: white-list approach.
    after_action :verify_authorized, except: [:index, :home], unless: :skip_pundit?
    after_action :verify_policy_scoped, only: [:index], unless: :skip_pundit?

  def configure_permitted_parameters
    attributes = [:username, :first_name, :last_name, :email]
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: attributes)
    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: attributes)
  end

  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end
end
