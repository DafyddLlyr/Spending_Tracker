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

  def self.sum_merchant(merchant)
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

  def budget_advice
    return "not very good...!" if @user.budget_percent >= 100
    return "cutting things a bit fine." if @user.budget_percent >= 90
    return "alright." if @user.budget_percent >= 75
    return "good." if @user.budget_percent >= 60
    return "great." if @user.budget_percent >= 35
    return "perfect!" if @user.budget_percent >= 10
  end

  def biggest_category_hash
    sql = "SELECT SUM(value), category_id FROM transactions
    WHERE user_id = $1
    GROUP BY category_id
    ORDER BY sum DESC"
    values = [@user.id]
    result = SqlRunner.run(sql, values)
    return result
  end

  def biggest_category_sum
    value = biggest_category_hash[0]["sum"].to_i
    return pretty_print(value)
  end

  def biggest_category_name
    id = biggest_category_hash[0]["category_id"].to_i
    category = Category.find(id)
    return category.name.capitalize
  end

  def biggest_merchant_hash
    sql = "SELECT SUM(value), merchant_id FROM transactions
    WHERE user_id = $1
    GROUP BY merchant_id
    ORDER BY sum DESC"
    values = [@user.id]
    result = SqlRunner.run(sql, values)
    return result
  end

  def biggest_merchant_sum
    value = biggest_merchant_hash[0]["sum"].to_i
    return pretty_print(value)
  end

  def biggest_merchant_name
    id = biggest_merchant_hash[0]["merchant_id"].to_i
    merchant = Merchant.find(id)
    return merchant.name
  end

  def pretty_print(value)
    if value <= 0
      result = "0.00"
    elsif value.digits.count == 1
      result = "0.0#{value}"
    elsif value.digits.count == 2
      result = "0.#{value}"
    else
      result = value.to_s.insert(-3, ".")
    end
    return "£#{result}"
  end

  def status_text
    status = 100 - @user.budget_percent
    return "#{status}%"
  end

end
