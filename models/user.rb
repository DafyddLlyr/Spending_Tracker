require_relative("../db/sql_runner")

class User

  attr_reader :id, :first_name, :last_name, :birth_date
  attr_accessor :budget_pounds, :budget_pence, :spent_pounds, :spent_pence, :goal

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @first_name = options["first_name"]
    @last_name = options["last_name"]
    @birth_date = Date.parse(options["birth_date"])
    @budget_pounds = options["budget_pounds"].to_i
    @budget_pence = options["budget_pence"].to_i
    @spent_pounds = options["spent_pounds"].to_i
    @spent_pence = options["spent_pence"].to_i
    @goal = options["goal"].chomp
  end

  def pretty_budget()
    @budget_pence < 10 ? "£#{@budget_pounds}.0#{@budget_pence}" : "£#{@budget_pounds}.#{@budget_pence}"
  end

  def pretty_spent_budget()
    @spent_pence < 10 ? "£#{@spent_pounds}.0#{@spent_pence}" : "£#{@spent_pounds}.#{@spent_pence}"
  end

  def resolve_budget()
    if @spent_pence >= 100
      @spent_pounds += 1
      @spent_pence -= 100
    end
  end

  def pretty_remaining_budget()
    pounds = @budget_pounds - @spent_pounds
    pence = @budget_pence - @spent_pence

    (pence += 100; pounds -= 1) if pence < 0

    pence < 10 ? "£#{pounds}.0#{pence}" : "£#{pounds}.#{pence}"
  end

  def budget_percent
    budget_float = ((@budget_pounds * 100) + @budget_pence).to_f
    spent_float = ((@spent_pounds * 100) + @spent_pence).to_f
    return ((spent_float / budget_float) * 100).to_i
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
      budget_pounds,
      budget_pence,
      spent_pounds,
      spent_pence,
      goal
    )
    VALUES ($1, $2, $3, $4, $5, $6, $7, $8) RETURNING id"
    values = [@first_name, @last_name, @birth_date, @budget_pounds, @budget_pence, @spent_pounds, @spent_pence, @goal]
    result = SqlRunner.run(sql, values)
    @id = result[0]["id"].to_i
  end

  def update()
    sql = "UPDATE users SET
    (
      budget_pounds,
      budget_pence,
      spent_pounds,
      spent_pence,
      goal
    )
    = ($1, $2, $3, $4, $5) WHERE id = $6"
    values = [@budget_pounds, @budget_pence, @spent_pounds, @spent_pence, @goal, @id]
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
