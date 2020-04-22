class ContactsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create]

  def new
    @contact = Contact.new
    authorize @contact
  end

  def create
    @contact = Contact.new(contact_params)
    authorize @contact
    if @contact.save
      UserMailer.general_message(@contact).deliver
      flash.notice = "Merci pour le message ! Je reviens vers toi rapidement."
      redirect_to root_path
    else
      redirect_to root_path(anchor: 'contact', contact_info: {name: @contact.name, email: @contact.email, message: @contact.message, errors: @contact.errors.messages})
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :message)
  end
end
