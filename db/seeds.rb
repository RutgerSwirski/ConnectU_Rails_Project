puts "Creating Users..."
50.times do 
	User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, description: Faker::Lorem.paragraphs(5), email: Faker::Internet.email, password: '123456')
end

puts "Creating Trips..."
User.all.each do |user|
	Trip.create(name: Faker::Nation.capital_city, date_arriving: Faker::Date.forward(23), date_leaving: Faker::Date.forward(50), description: Faker::Lorem.paragraphs(10), funding_total_cents: Faker::Number.between(1000, 100000), ticket_quantity: 250, available_tickets: 250, ticket_price_cents: Faker::Number.between(1000, 10000), ticket_name: "Regular", ticket_description: Faker::Lorem.paragraphs(2), destination: Faker::Nation.capital_city, departing_from: Faker::Nation.capital_city, user: user)
end

puts 'Adding Trip Photos...'
Trip.all.each do |trip|
	TripPhoto.create(trip: trip)
end

puts "Creating Homes..."
User.all.each do |user|
	Flat.create(name: "Amazing Home Overlooking City", description: Faker::Lorem.paragraphs(15), address: Faker::Address.city, user: user, price_cents: Faker::Number.between(1000, 10000))
end

puts "Adding House Photos..."
Flat.all.each do |flat|
	FlatPhoto.create(flat: flat)
end

puts "Creating Activities..."
User.all.each do |user|
	Activity.create(name: "Amazing Activity", date: Faker::Date.forward(50), address: Faker::Address.city, description: Faker::Lorem.paragraphs(6), user: user, price_cents: Faker::Number.between(1000, 10000), total_tickets: 100, available_tickets: 100)
end

puts "Adding Activity Photos..."
Activity.all.each do |activity|
	ActivityPhoto.create(activity: activity)
end

puts "Sending Messages..."
User.all.each do |user|
	Message.create(sender: user, recipient_id: rand(1..50), content: Faker::Lorem.paragraphs(3) )
end
puts "Done!"