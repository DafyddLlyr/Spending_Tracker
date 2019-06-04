require_relative("../models/category")
require_relative("../models/merchant")
require_relative("../models/user")
require_relative("../models/transaction")
require_relative("../models/budget")
require("pry")

Category.delete_all()
Merchant.delete_all()
User.delete_all()

category_1 = Category.new({ "name" => "food"})
category_1.save()

category_2 = Category.new({ "name" => "transport"})
category_2.save()

category_3 = Category.new({ "name" => "entertainment"})
category_3.save()

category_4 = Category.new({ "name" => "bills"})
category_4.save()

merchant_1 = Merchant.new({ "name" => "The Lion and Star" })
merchant_1.save

merchant_2 = Merchant.new({ "name" => "Tesco" })
merchant_2.save

merchant_3 = Merchant.new({ "name" => "First Bus" })
merchant_3.save

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

transaction_1 = Transaction.new( {
  "transaction_date" => "1/06/19",
  "value" => 499,
  "merchant_id" => merchant_2.id,
  "user_id" => user_1.id,
  "category_id" => category_1.id,
  "description" => "Popped out to get snacks"
  })
transaction_1.save()

transaction_2 = Transaction.new( {
  "transaction_date" => "1/05/19",
  "value" => 1099,
  "merchant_id" => merchant_2.id,
  "user_id" => user_1.id,
  "category_id" => category_2.id,
  "description" => "Weekly bus ticket"
  })
transaction_2.save()

budget = Budget.new(user_1)

binding.pry
nil
