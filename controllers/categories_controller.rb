require("sinatra")
require("sinatra/contrib/all")
require_relative("../models/transaction")
require_relative("../models/user")
require_relative("../models/merchant")
require_relative("../models/category")
also_reload('../models/*')

get "/users/:user_id/categories" do
  @user = User.find(params["user_id"])
  @categories = @user.categories()
  erb(:"users/categories/index")
end

get "/users/:user_id/categories/new" do
  @user = User.find(params["user_id"].to_i)
  erb(:"users/categories/new")
end

post "/users/:user_id/categories" do
  @category = Category.new(params)
  @category.save()
  @user = User.find(params["user_id"].to_i)
  erb(:"users/categories/created")
end

get "/users/:user_id/categories/:id" do
  @user = User.find(params["user_id"])
  @category = Category.find(params["id"])
  @transactions = Transaction.all()
  erb(:"users/categories/show")
end

get "/users/:user_id/categories/:id/edit" do
  @user = User.find(params["user_id"])
  @category = Category.find(params["id"])
  erb(:"users/categories/edit")
end

post "/users/:user_id/categories/:id" do
  @user = User.find(params["user_id"].to_i)
  @category = Category.new(params)
  @category.update()
  erb(:"users/categories/updated")
end
