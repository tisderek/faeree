class User < ActiveRecord::Base
  include SecureRandom

	EMAIL_REGEX = /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\Z/i


	validates :name, presence:true
	validates :phone, presence:true, uniqueness: true, numericality: true, length: { is: 10 }
	validates :email, presence:true, uniqueness: true, format: EMAIL_REGEX

	has_many  :events
  has_many  :contacts

  private 
  
  def generate_token
    new_token = SecureRandom.hex
    self.update_attribute(:token, new_token)
  end

  def send_sms(body_text)

    to_number = self.phone
    twilio_SID = 'AC353193f53993d0d25fde1832142cb278'
    twilio_token = 'a1fdbf3a9b4f14136ce094e57aafa90e'
    client = Twilio::REST::Client.new twilio_SID, twilio_token
    from = '+14152341719'

    message = client.account.messages.create(
        from: from,
        to: to_number,
        body: body_text
      )
  end

end
