require("sinatra")
require("sinatra/contrib/all")
require_relative("../models/user")
require_relative("../models/budget")
also_reload( '../models/*' )

get "/users/:id" do
  @user = User.find(params["id"])
  @budget = Budget.new(@user)
  # binding.pry
  erb(:"users/show")
end
