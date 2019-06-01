require_relative("../models/category")
require("pry")

Category.delete_all()

category1 = Category.new({ "name" => "food"})
category1.save()

category2 = Category.new({ "name" => "transport"})
category2.save()

category3 = Category.new({ "name" => "entertainment"})
category3.save()

category4 = Category.new({ "name" => "bills"})
category4.save()

binding.pry
nil
