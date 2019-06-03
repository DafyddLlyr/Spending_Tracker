require_relative("../db/sql_runner")

class Transaction

  attr_reader :id, :user_id
  attr_accessor :transaction_date, :pounds, :pence, :merchant_id, :category_id, :description

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @transaction_date = Date.parse(options["transaction_date"])
    @pounds = options["pounds"].to_i
    @pence = options["pence"].to_i
    @merchant_id = options["merchant_id"].to_i
    @user_id = options["user_id"].to_i
    @category_id = options["category_id"].to_i
    @description = options["description"].chomp
  end

  def save()
    sql = "INSERT INTO transactions
    (
      transaction_date,
      pounds,
      pence,
      merchant_id,
      user_id,
      category_id,
      description
    )
    VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING id"
    values = [@transaction_date, @pounds, @pence, @merchant_id, @user_id, @category_id, @description]
    result = SqlRunner.run(sql, values)
    @id = result[0]["id"].to_i
  end

  def update()
    sql = "UPDATE transactions SET
    (
      transaction_date,
      pounds,
      pence,
      merchant_id,
      user_id,
      category_id,
      description
    )
    = ($1, $2, $3, $4, $5, $6, $7) WHERE id = $8"
    values = [@transaction_date, @pounds, @pence, @merchant_id, @user_id, @category_id, @description, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM transactions WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def pretty_value()
   @pence < 10 ? "£#{@pounds}.0#{@pence}" : "£#{@pounds}.#{@pence}"
  end

  def pretty_description()
    @description.length > 30 ? @description[0..30].concat("...") : @description
  end

  def pretty_date()
    return @transaction_date.strftime("%d/%m/%Y")
  end

  def merchant()
    sql = "SELECT * FROM merchants WHERE id = $1"
    values = [@merchant_id]
    result = SqlRunner.run(sql, values)
    return Merchant.new(result[0])
  end

  def category()
    sql = "SELECT * FROM categories WHERE id = $1"
    values = [@category_id]
    result = SqlRunner.run(sql, values)
    return Category.new(result[0])
  end

  def self.all()
    sql = "SELECT * FROM transactions ORDER BY transaction_date DESC"
    results = SqlRunner.run(sql)
    return results.map { |transaction| Transaction.new(transaction) }
  end

  def self.find(id)
    sql = "SELECT * FROM transactions WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)
    return Transaction.new(result[0])
  end

end
