require("sinatra")
require("sinatra/contrib/all")
require_relative("../models/user")
require_relative("../models/budget")
require_relative("../models/greeter")
also_reload( '../models/*' )

get "/users/:id" do
  @greetings = Greeter.greeting
  @user = User.find(params["id"])
  @budget = Budget.new(@user)
  # binding.pry
  erb(:"users/show")
end

get "/users/:id/edit" do
  @user = User.find(params["id"])
  erb(:"users/edit")
end

post "/users/:id" do
  @user = User.find(params["id"])
  @user.budget_pounds = params["budget_pounds"].to_i
  @user.budget_pence = params["budget_pence"].to_i
  if params["reset"] == "on"
    @user.spent_pounds = 0
    @user.spent_pence = 0
  end
  @user.update
  erb(:"users/updated")
end
