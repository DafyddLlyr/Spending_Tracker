class Budget

  def initialize(user)
    @user = user
  end

  def sum_pounds(grouping)
    grouping_id = grouping.class.to_s.downcase.concat("_id")
    sql = "SELECT SUM(value) FROM transactions
    WHERE" + grouping_id + " = $1 AND user_id = $2"
    values = [grouping.id, @user.id]
    result = SqlRunner.run(sql, values)
    return result[0]["sum"].to_i
  end

  def pretty_value(grouping)
    value = sum_pounds(grouping)
    @value.to_s.insert(-3, ".").prepend("£")
  end

  def status
    status = 100 - @user.budget_percent
    return "budget-00" if status <= 0
    return "budget-10" if status <= 10
    return "budget-20" if status <= 20
    return "budget-30" if status <= 30
    return "budget-40" if status <= 40
    return "budget-50" if status <= 50
    return "budget-60" if status <= 60
    return "budget-70" if status <= 70
    return "budget-80" if status <= 80
    return "budget-90" if status <= 90
    return "TEST"
  end

  def status_text
    status = 100 - @user.budget_percent
    if status < 0
      result = "You are currently #{-status}% past your set budget"
    else
      result = "You have #{status}% remining."
    end
    return result
  end

end
