require_relative("../models/category")
require_relative("../models/merchant")
require_relative("../models/user")
require_relative("../models/transaction")
require_relative("../models/budget")
require("pry")

Category.delete_all()
Merchant.delete_all()
User.delete_all()

category_1 = Category.new({ "name" => "Food"})
category_1.save()

category_2 = Category.new({ "name" => "Transport"})
category_2.save()

category_3 = Category.new({ "name" => "Entertainment"})
category_3.save()

category_4 = Category.new({ "name" => "Bills"})
category_4.save()

category_5 = Category.new({ "name" => "Petrol"})
category_5.save()

category_6 = Category.new({ "name" => "Nights Out"})
category_6.save()

category_7 = Category.new({ "name" => "Clothes"})
category_7.save()

category_8 = Category.new({ "name" => "Pet Supplies"})
category_8.save()

merchant_1 = Merchant.new( {
  "name" => "Amazon",
  "logo" => "/images/logos/amazon.jpg"
  })
merchant_1.save

merchant_2 = Merchant.new( {
  "name" => "Tesco",
  "logo" => "/images/logos/tesco.jpg"
  })
merchant_2.save

merchant_3 = Merchant.new( {
  "name" => "First Bus",
  "logo" => "/images/logos/first_bus.jpg"
  })
merchant_3.save

merchant_4 = Merchant.new( {
  "name" => "ScotRail",
  "logo" => "/images/logos/scotrail.jpg"
  })
merchant_4.save

merchant_5 = Merchant.new( {
  "name" => "Howling Wolf",
  "logo" => "/images/logos/howling_wolf.jpg"
  })
merchant_5.save

merchant_6 = Merchant.new( {
  "name" => "Sky TV",
  "logo" => "/images/logos/sky.jpg"
  })
merchant_6.save

merchant_7 = Merchant.new( {
  "name" => "Greggs",
  "logo" => "/images/logos/greggs.jpg"
  })
merchant_7.save

merchant_8 = Merchant.new( {
  "name" => "Starbucks",
  "logo" => "/images/logos/starbucks.jpg"
  })
merchant_8.save

merchant_9 = Merchant.new( {
  "name" => "Lidl",
  "logo" => "/images/logos/lidl.jpg"
  })
merchant_9.save

merchant_10 = Merchant.new( {
  "name" => "Scottish Power",
  "logo" => "/images/logos/scottish_power.jpg"
  })
merchant_10.save

user_1 = User.new ( {
    "first_name" => "Dafydd",
    "last_name" => "Pearson",
    "birth_date" => "5th Feb 1980",
    "budget" => 50000,
    "spent" => 0,
    "goal" => "I want to save for a holiday",
    "savings" => 0
  } )
user_1.save()

# transaction_1 = Transaction.new( {
#   "transaction_date" => "1/06/19",
#   "value" => 499,
#   "merchant_id" => merchant_2.id,
#   "user_id" => user_1.id,
#   "category_id" => category_1.id,
#   "description" => "Popped out to get snacks"
#   })
# transaction_1.save()
#
# transaction_2 = Transaction.new( {
#   "transaction_date" => "1/05/19",
#   "value" => 1099,
#   "merchant_id" => merchant_2.id,
#   "user_id" => user_1.id,
#   "category_id" => category_2.id,
#   "description" => "Weekly bus ticket"
#   })
# transaction_2.save()

budget = Budget.new(user_1)

binding.pry
nil
