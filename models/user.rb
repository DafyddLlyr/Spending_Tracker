require_relative("../db/sql_runner")

class User

  attr_reader :id, :first_name, :last_name, :birth_date
  attr_accessor :budget, :spent, :goal

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @first_name = options["first_name"]
    @last_name = options["last_name"]
    @birth_date = Date.parse(options["birth_date"])
    @budget = options["budget"].to_i
    @spent = options["spent"].to_i
    @goal = options["goal"].chomp
  end

  def pretty_print(value)
    value.to_s.insert(-3, ".").prepend("£")
  end

  def remaining_budget()
    return @budget - @spent
  end

  def budget_percent
    return (@spent.to_f / @budget.to_f) * 100.to_i
  end

  def pretty_budget_percent
    return "#{budget_percent}%"
  end

  def save()
    sql = "INSERT INTO users
    (
      first_name,
      last_name,
      birth_date,
      budget,
      spent,
      goal
    )
    VALUES ($1, $2, $3, $4, $5, $6) RETURNING id"
    values =
    [
      @first_name,
      @last_name,
      @birth_date,
      @budget,
      @spent,
      @goal
    ]
    result = SqlRunner.run(sql, values)
    @id = result[0]["id"].to_i
  end

  def update()
    sql = "UPDATE users SET
    (
      budget,
      spent,
      goal
    )
    = ($1, $2, $3, $4, $5) WHERE id = $6"
    values =
    [
      @budget,
      @spent,
      @goal,
      @id
    ]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM users WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def transactions()
    sql = "SELECT * FROM transactions
    WHERE user_id = $1
    ORDER BY transaction_date DESC"
    values = [@id]
    results = SqlRunner.run(sql, values)
    return results.map { |transaction| Transaction.new(transaction) }
  end

  def merchants()
    sql = "SELECT * FROM merchants
    INNER JOIN transactions
    ON transactions.user_id = $1
    WHERE transactions.merchant_id = merchants.id"
    values = [@id]
    results = SqlRunner.run(sql, values)
    return results.map { |merchant| Merchant.new(merchant) }
  end

  def categories()
    sql = "SELECT * FROM categories
    INNER JOIN transactions
    ON transactions.user_id = $1
    WHERE transactions.category_id = categories.id"
    values = [@id]
    results = SqlRunner.run(sql, values)
    return results.map { |category| Category.new(category) }
  end

  def self.all()
    sql = "SELECT * FROM users"
    results = SqlRunner.run(sql)
    return results.map { |user| User.new(user) }
  end

  def self.find(id)
    sql = "SELECT * FROM users WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)
    return User.new(result[0])
  end

  def self.delete_all()
    sql = "DELETE FROM users"
    SqlRunner.run(sql)
  end

end
