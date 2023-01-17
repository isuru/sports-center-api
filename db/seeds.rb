#
# Create some courts as initial data for booking in the sports center, 
# assuming the center occupies 3 - tennis courts, 2 - basketball courts, 1 - football court & 2 - volleyball courts.
#
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
