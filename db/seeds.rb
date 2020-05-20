# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
Product.create([{ code:  'CC', name:  'Coca-Cola', price: 1.50 },
                { code:  'PC', name:  'Pepsi-Cola', price: 2.00 },
                { code:  'WA', name:  'Water', price: 0.85 }])

cart = Cart.create
co = Checkout.new(cart: cart)
co.add_item("CC")
co.add_item("CC")
co.add_item("PC")
co.add_item("WA")

order1 = Order.new
order2 = Order.new
order1.line_items = cart.line_items
order2.line_items = cart.line_items
order1.save
order2.save
order2.update_attributes(created_at: Date.today - 1.month)
