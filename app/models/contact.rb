class Contact < ActiveRecord::Base

  
  validates :contact_phone, presence:true, uniqueness: true, numericality: true, length: { is: 10 }
  validates :contact_name, presence:true

  belongs_to  :user
end
