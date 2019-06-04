require("sinatra")
require("sinatra/contrib/all")
require_relative("../models/transaction")
require_relative("../models/user")
require_relative("../models/merchant")
require_relative("../models/category")
also_reload('../models/*')

get "/users/:user_id/transactions" do
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
  @transaction.value = (params["pounds"].to_i * 100) + params["pence"].to_i
  @transaction.save()
  @user = User.find(params["user_id"].to_i)
  @user.spent += @transaction.value
  @user.update()
  erb(:"/users/transactions/created")
end

get "/users/:user_id/transactions/:id" do
  @transaction = Transaction.find(params["id"])
  erb(:"users/transactions/show")
end

post "/users/:user_id/transactions/:id/delete" do
  @transaction = Transaction.find(params["id"])
  @user = User.find(params["user_id"].to_i)
  @user.spent -= @transaction.value if @user.spent > 0
  @user.update()
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
  @transaction = Transaction.new(params)
  new_value = (params["pounds"].to_i * 100) + params["pence"].to_i
  difference = new_value - @transaction.value
  @transaction.value = new_value
  @transaction.update()
  @user = User.find(params["user_id"].to_i)
  @user.spent += difference
  @user.update()
  erb(:"users/transactions/updated")
end
