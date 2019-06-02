require("sinatra")
require("sinatra/contrib/all")
require("pry")
require_relative("controllers/categories_controller")
require_relative("controllers/users_controller")
require_relative("controllers/merchants_controller")
require_relative("controllers/transactions_controller")
require_relative("models/user")
also_reload('/models/*')

get "/" do
  @users = User.all()
  erb(:index)
end
