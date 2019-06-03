require("sinatra")
require("sinatra/contrib/all")
require_relative("../models/transaction")
require_relative("../models/user")
require_relative("../models/merchant")
require_relative("../models/category")
also_reload('../models/*')

get "/users/:user_id/merchants" do
  @user = User.find(params["user_id"])
  @budget = Budget.new(@user)
  @merchants = @user.merchants()
  # binding.pry
  erb(:"/users/merchants/index")
end

get "/users/:user_id/merchants/new" do
  @user = User.find(params["user_id"].to_i)
  erb(:"users/merchants/new")
end

post "/users/:user_id/merchants" do
  @merchant = Merchant.new(params)
  @merchant.save()
  @user = User.find(params["user_id"].to_i)
  erb(:"users/merchants/created")
end

get "/users/:user_id/merchants/:id" do
  @user = User.find(params["user_id"])
  @merchant = Merchant.find(params["id"])
  @transactions = Transaction.all()
  erb(:"users/merchants/show")
end

get "/users/:user_id/merchants/:id/edit" do
  @user = User.find(params["user_id"])
  @merchant = Merchant.find(params["id"])
  erb(:"users/merchants/edit")
end

post "/users/:user_id/merchants/:id" do
  @user = User.find(params["user_id"].to_i)
  @merchant = Merchant.new(params)
  @merchant.update()
  erb(:"users/merchants/updated")
end
