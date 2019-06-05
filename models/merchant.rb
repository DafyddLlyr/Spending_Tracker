require_relative("../db/sql_runner")
# require_relative("transaction")

class Merchant

  attr_reader :id
  attr_accessor :name, :logo

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @name = options["name"]
    @logo = options["logo"]
  end

  def save()
    sql = "INSERT INTO merchants(name, logo) VALUES ($1, $2) RETURNING id"
    values = [@name, @logo]
    result = SqlRunner.run(sql, values)
    @id = result[0]["id"].to_i
  end

  def update()
    sql = "UPDATE merchants SET (name, logo) = ($1, $2) WHERE id = $2"
    values = [@name, @logo, @id]
    SqlRunner.run(sql, values)
  end

  def self.user_transactions(user)
    sql = "SELECT * FROM transactions
    WHERE merchant_id = $1
    AND user_id = $2"
    values = [@id, user.id]
    results = SqlRunner.run(sql, values)
    return results.map { |transaction| Transaction.new(transaction) }
  end

  def self.all()
    sql = "SELECT * FROM merchants"
    results = SqlRunner.run(sql)
    return results.map { |merchant| Merchant.new(merchant) }
  end

  def self.find(id)
    sql = "SELECT * FROM merchants WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)
    return Merchant.new(result[0])
  end

  def self.find_name(name)
    sql = "SELECT * FROM merchants WHERE name = $1"
    values = [name]
    result = SqlRunner.run(sql, values)
    return Merchant.new(result[0])
  end

  def self.delete_all()
    sql = "DELETE FROM merchants"
    SqlRunner.run(sql)
  end


end
