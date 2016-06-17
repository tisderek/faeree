# ImportHelper::ItineraryImport.process_all

itineraries_seed_file = File.join(Rails.root, 'db', 'itineraries_seed', 'itineraries_seed.shp')
RGeo::Shapefile::Reader.open(itineraries_seed_file) do |file|
  file.each do |item|
    record = Hash[item.attributes.map{|(k,v)| [k.downcase.to_sym,v]}]
    record.delete(:blockside)
    record.delete(:blocksweep)
    record.delete(:cnn)
    record.delete(:corridor)
    record.delete(:district)
    record.delete(:nhood)
    record.delete(:zip_code)
    Itinerary.create(record)
  end
  file.rewind
  item = file.next
end

User.create(
    name: "Derek",
    email: "derek@faeree.co",
    phone: 4154168686,
    password: 12341234
)



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
