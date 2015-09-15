# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(
    name: "Derek",
    email: "the@admin.com",
    phone: 4154168654,
    password: 123123
  )


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