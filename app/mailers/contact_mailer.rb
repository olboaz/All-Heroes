class ContactMailer < ApplicationMailer
  def the_message(contact)
    @contact = contact
    mail(:from => @contact.email, :to => ENV['GMAIL_USERNAME'], :subject => "All-heroes Contact")
  end
end
