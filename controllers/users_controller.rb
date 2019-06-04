require("sinatra")
require("sinatra/contrib/all")
require_relative("../models/user")
require_relative("../models/budget")
require_relative("../models/greeter")
require_relative("../models/advisor")
also_reload( '../models/*' )

get "/users/:id" do
  @greetings = Greeter.greeting
  @user = User.find(params["id"])
  @budget = Budget.new(@user)
  @advisor = Advisor.new(@user)
  erb(:"users/show")
end

get "/users/:id/edit" do
  @user = User.find(params["id"])
  erb(:"users/edit")
end

post "/users/:id" do
  @user = User.find(params["id"])
  new_budget = (params["pounds"].to_i * 100) + params["pence"].to_i
  @user.budget = new_budget
  @user.spent = 0 if params["reset"] == "on"
  @user.goal = params["goal"]
  @user.update
  erb(:"users/updated")
end
