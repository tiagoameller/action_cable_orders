# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Plu.create(name: 'Patatas fritas', price: 1.95)
Plu.create(name: 'Calamares', price: 2.95)
Plu.create(name: 'Bravas', price: 3.95)
Plu.create(name: 'Pulpo', price: 4.95)
Plu.create(name: 'Almejas', price: 5.95)

order = Order.create(name: 'Manolo')
order.order_items.create(plu: Plu.first, units: 1)
order.order_items.create(plu: Plu.second, units: 2)
order.order_items.create(plu: Plu.last, units: 3)

order = Order.create(name: 'Perico')
order.order_items.create(plu: Plu.last, units: 1)
order.order_items.create(plu: Plu.second, units: 2)
order.order_items.create(plu: Plu.first, units: 3)
