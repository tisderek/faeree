require 'rgeo/shapefile'

User.create(
    name: "Derek",
    email: "the@admin.com",
    phone: 4154168654,
    password: 123123
)

itineraries_seed_file = File.join(Rails.root, 'db', 'itineraries_seed', 'itineraries_seed.shp')
RGeo::Shapefile::Reader.open(itineraries_seed_file) do |file|
  file.each do |record|
    args = Hash[record.attributes.map{|(k,v)| [k.downcase.to_sym,v]}]
    args.delete(:blockside)
    args.delete(:blocksweep)
    args.delete(:cnn)
    args.delete(:corridor)
    args.delete(:district)
    args.delete(:nhood)
    args.delete(:zip_code)
    if args[:weekday] == "Sun"
      args[:weekday] = "Sunday"
    elsif args[:weekday] == "Mon"
      args[:weekday] = "Monday"
    elsif args[:weekday] == "Tue"
      args[:weekday] = "Tuesday"
    elsif args[:weekday] == "Wed"
      args[:weekday] = "Wednesday"
    elsif args[:weekday] == "Thu"
      args[:weekday] = "Thursday"
    elsif args[:weekday] == "Fri"
      args[:weekday] = "Friday"
    elsif args[:weekday] == "Sat"
      args[:weekday] = "Saturday"
    end
    Itinerary.create(args)
    break if record.index == 2000
  end
  file.rewind
  record = file.next
end

Contact.create(
    contact_name: "Leo",
    contact_phone: 9172735014,
    user_id: 1
  )

Contact.create(
    contact_name: "Karen",
    contact_phone: 4152239884,
    user_id: 1
  )
