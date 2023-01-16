# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Create some courts as initial data for booking in the sports center, 
# assuming the center occupies 3 - tennis courts, 2 - basketball courts, 1 - football court & 2 - volleyball courts.
Court.create([
	# for tennis: 
	{name: 'T1', type_id: 1}, {name: 'T2', type_id: 1}, {name: 'T3', type_id: 1}, 
	# for basketball: 
	{name: 'B1', type_id: 2}, {name: 'B2', type_id: 2}, 
	# for football: 
	{name: 'F1', type_id: 3},  
	# for volleyball: 
	{name: 'V1', type_id: 4}, {name: 'V2', type_id: 4}
])
