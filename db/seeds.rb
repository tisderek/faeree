require 'rgeo/shapefile'

User.create(
    name: "Derek",
    email: "derek@faeree.co",
    phone: 4154168686,
    password: 12341234
)

Event.create(
  lat: 37.769185,
  lng: -122.430613,
  user_id: 1
)

Event.create(
  lat: 37.769618,
  lng: -122.430886,
  user_id: 1
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
    p "********* ARGS *************"
    p args
    p "********* OBJ *************"
    p Itinerary.create(args)
    break if record.index == 100
  end
  file.rewind
  record = file.next
end


Contact.create(
    contact_name: "Leo",
    contact_phone: 9172735555,
    user_id: 1
  )

Contact.create(
    contact_name: "Karen",
    contact_phone: 4152239999,
    user_id: 1
  )
