# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
["Doctor","Lawyer","Engineer","Armed Forces"].each do |pos|
  Position.where(pos_type: Position::VALID_TYPES[:public], name: pos).first_or_create
  puts "Added #{pos}"
end

EntityStatus::VALID_TYPES.each do |type|
  EntityStatus.where(name: "NA", code: "NA", entity_type: type).first_or_create
  puts "Added statuses NA to #{type}"
end
