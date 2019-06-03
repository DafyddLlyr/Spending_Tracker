class Advisor

  attr_reader :user, :goals

  def initialize(user)
    @user = user
    @goals = ["holiday", "house", "car", "birthday", "wedding", "codeclan", "education"]
  end

  def user_goal()
    return @goals.select { |word| @user.goal.include?(word) }
  end

  def img()
    goal = user_goal()
    goal.length == 0 ? @goals.sample.concat(".jpg") : goal[0].concat(".jpg")
  end

end
