module UsersHelper

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
