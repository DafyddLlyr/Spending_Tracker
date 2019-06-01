require("sinatra")
require("sinatra/contrib/all")
require_relative("../models/transaction")
require_relative("../models/user")
require_relative("../models/merchant")
require_relative("../models/category")
also_reload('../models/*')

get "/users/:user_id/transactions/" do
  @user = User.find(params["user_id"])
  @transactions = @user.transactions()
  erb(:"users/transactions/index")
end

get "/users/:user_id/transactions/new" do
  @user = User.find(params["user_id"].to_i)
  @merchants = Merchant.all()
  @categories = Category.all()
  erb(:"users/transactions/new")
end

post "/users/:user_id/transactions" do
  @transaction = Transaction.new(params)
  @transaction.save()
  erb(:"/users/transactions/created")
end

get "/users/:user_id/transactions/:id" do
  @transaction = Transaction.find(params["id"])
  erb(:"users/transactions/show")
end

post "/users/:user_id/transactions/:id/delete" do
  @transaction = Transaction.find(params["id"])
  @transaction.delete()
  erb(:"users/transactions/deleted")
end

get "/users/:user_id/transactions/:id/edit" do
  @user = User.find(params["user_id"].to_i)
  @merchants = Merchant.all()
  @categories = Category.all()
  @transaction = Transaction.find(params["id"])
  erb(:"users/transactions/edit")
end

post "/users/:user_id/transactions/:id" do
  @transaction = Transaction.find(params["id"])
  @transaction.update()
  erb(:"users/transactions/updated")
end
