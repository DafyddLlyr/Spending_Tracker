class Advisor

  attr_reader :user, :goals

  def initialize(user)
    @user = user
    @goals =
    [
      "holiday",
      "house",
      "car",
      "birthday",
      "wedding",
      "codeclan",
      "education",
      "dog",
      "retire"
    ]
  end

  def user_goal()
    return @goals.select { |word| @user.goal.include?(word) }
  end

  def img()
    goal = user_goal()
    goal.length == 0 ? "saving.jpg" : goal[0].concat(".jpg")
  end

end
