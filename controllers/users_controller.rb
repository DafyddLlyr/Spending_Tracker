require("sinatra")
require("sinatra/contrib/all")
require_relative("../models/user")
also_reload( '../models/*' )

get "/users/:id" do
  @user = User.find(params["id"])
  erb(:"users/show")
end
