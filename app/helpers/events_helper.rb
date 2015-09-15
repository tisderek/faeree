module EventsHelper
  def send_sms(to_number, body_text)

    twilio_SID = 'AC353193f53993d0d25fde1832142cb278'
    twilio_token = 'a1fdbf3a9b4f14136ce094e57aafa90e'
    client = Twilio::Rest::Client.new twilio_SID, twilio_token
    from = '+14152341719'

    message = client.account.messages.create(
      from: from,
      to: to_number,
      body: body_text
      )
  end
  
  def format_datetime(datetime)
    datetime.getlocal.strftime(
      "%A, %b #{datetime.day.ordinalize} at %l:%M%P"
      )
  end
end


module DateTimeHelper

  def next_week
    self + (7 - self.wday)
  end

  def next_wday(n)
    n > self.wday ? self + (n - self.wday) : self.next_week.next_day(n)
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