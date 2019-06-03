class Budget

  def initialize(user)
    @user = user
  end

  def merc_sum_pounds(grouping)
    # grouping_id = grouping.class.to_s.downcase.concat("_id")
    sql = "SELECT SUM(pounds) FROM transactions
    WHERE merchant_id = $1 AND user_id = $2"
    values = [grouping.id, @user.id]
    result = SqlRunner.run(sql, values)
    return result[0]["sum"].to_i
  end

  def merc_sum_pence(grouping)
    # grouping_id = grouping.class.to_s.downcase.concat("_id")
    sql = "SELECT SUM(pence) FROM transactions
    WHERE merchant_id = $1 AND user_id = $2"
    values = [grouping.id, @user.id]
    result = SqlRunner.run(sql, values)
    return result[0]["sum"].to_i
  end

  def merc_resolve_total(grouping)
    pounds = merc_sum_pounds(grouping)
    pence = merc_sum_pence(grouping)

    pounds += pence / 100
    pence %= 100

    return { "pounds" => pounds, "pence" => pence }
  end

  def status
    status = 100 - @user.budget_percent
    return "budget-10" if status <= 10
    return "budget-20" if status <= 20
    return "budget-30" if status <= 30
    return "budget-40" if status <= 40
    return "budget-50" if status <= 50
    return "budget-60" if status <= 60
    return "budget-70" if status <= 70
    return "budget-80" if status <= 80
    return "budget-90" if status <= 90
    return "budget-100"
  end


end
