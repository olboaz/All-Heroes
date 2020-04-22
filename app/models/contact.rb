class Contact < ApplicationRecord
  validates :email,
  :presence => :true,
  :format => {
    :with => /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i,
    :message => "format d'email non valide"
  }
  validates :message, :presence => :true
end
