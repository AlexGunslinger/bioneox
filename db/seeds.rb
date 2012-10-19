# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

states = State.create([{name: 'Texas', short_name: 'TX'}])
cities = City.create([{name: 'Austin', state_id: states.first.id}, {name: 'San Antonio', state_id: states.first.id}])
orders = OrderType.create([{name: 'Samples'}, {name: 'Test'}, {name: 'Special Request'}])
sample_types = SampleType.create([{name: 'TTOP'}, {name: 'RED'}, {name: 'LAV'}, {name: 'GRAY'}, {name: 'BLUE'}, {name: 'DKBLU'}, {name: 'GREEN'}, {name: 'YELLOW'}, {name: 'SERUM'}, {name: 'URINE'}, {name: 'STOOL'}, {name: 'CULTR'}, {name: 'PAP'}, {name: 'TISSU'}])