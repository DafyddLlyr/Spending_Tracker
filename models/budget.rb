class Budget

  def initialize(user)
    @user = user
  end

  def total_spending()
    return @user.transactions.sum { |transaction| transaction.value }
  end

  def sum_category(category)
    sql = "SELECT SUM(value) FROM transactions
    WHERE category_id = $1 AND user_id = $2"
    values = [category.id, @user.id]
    result = SqlRunner.run(sql, values)
    return result[0]["sum"].to_i
  end

  def category_largest(category)
    sql = "SELECT * FROM transactions
    WHERE category_id = $1 AND user_id = $2
    ORDER BY transactions.value DESC"
    values = [category.id, @user.id]
    result = SqlRunner.run(sql, values)
    return Transaction.new(result[0])
  end

  def category_percent(category)
    total_category = sum_category(category)
    total_spending = total_spending()
    return ((total_category.to_f / total_spending.to_f) * 100).to_i
  end

  def sum_merchant(merchant)
    sql = "SELECT SUM(value) FROM transactions
    WHERE merchant_id = $1 AND user_id = $2"
    values = [merchant.id, @user.id]
    result = SqlRunner.run(sql, values)
    return result[0]["sum"].to_i
  end

  def merchant_largest(merchant)
    sql = "SELECT * FROM transactions
    WHERE merchant_id = $1 AND user_id = $2
    ORDER BY transactions.value DESC"
    values = [merchant.id, @user.id]
    result = SqlRunner.run(sql, values)
    return Transaction.new(result[0])
  end

  def merchant_percent(merchant)
    total_merchant = sum_merchant(merchant)
    total_spending = total_spending()
    return ((total_merchant.to_f / total_spending.to_f) * 100).to_i
  end

  def savings_amount
    return @user.pretty_print(@user.savings)
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
    return "budget-100"
  end

  def status_text
    status = 100 - @user.budget_percent
    return "#{status}%"
  end

end
