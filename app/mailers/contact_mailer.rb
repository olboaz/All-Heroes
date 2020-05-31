class ContactMailer < ApplicationMailer
  def the_message(contact)
    @contact = contact
    # mail(from: @contact.email, to: 'spalkes04@gmail.com', subject: @contact.message)
    # This will render a view in `app/views/contact_mailer`!
     mail(:from => @contact.email, :to => 'spalkes04@gmail.com', :subject => "Registered")
  end
end
