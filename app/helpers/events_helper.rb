module EventsHelper
  
  def send_sms(body_text)

    twilio_SID = 'AC353193f53993d0d25fde1832142cb278'
    twilio_token = 'a1fdbf3a9b4f14136ce094e57aafa90e'
    client = Twilio::Rest::Client.new twilio_SID, twilio_token
    from = '+14152341719'
    to_number = self.user.phone

    message = client.account.messages.create(
      from: from,
      to: to_number,
      body: body_text
      )
  end
  
  def format_datetime(datetime)
    datetime.strftime(
      "%A, %b #{datetime.day.ordinalize} at %l:%M%P"
      )
  end

  def countdown_to(datetime)
    TimeDifference.between(datetime, Time.now).in_general
  end

  def countdown_days(datetime)
    countdown_to(datetime)[:days]
  end

  def countdown_hours(datetime)
    countdown_to(datetime)[:hours]
  end

  def countdown_minutes(datetime)
    countdown_to(datetime)[:minutes]
  end


end



class Fixnum
  def ordinalize
    if (11..13).include?(self % 100)
      "#{self}th"
    else
      case self % 10
      when 1; "#{self}st"
      when 2; "#{self}nd"
      when 3; "#{self}rd"
      else    "#{self}th"
      end
    end
  end
end