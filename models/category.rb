require_relative("../db/sql_runner")

class Category

  attr_reader :id
  attr_accessor :name

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @name = options["name"]
  end

  def save()
    sql = "INSERT INTO categories (name) VALUES ($1) RETURNING id"
    values = [@name]
    result = SqlRunner.run(sql, values)
    @id = result[0]["id"].to_i
  end

  def update()
    # This needs () for multiple values
    sql = "UPDATE categories SET name = $1 WHERE id = $2"
    values = [@name, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM categories WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.user_transactions(user)
    sql = "SELECT * FROM transactions
    WHERE category_id = $1
    AND user_id = $2"
    values = [@id, user.id]
    results = SqlRunner.run(sql, values)
    return results.map { |transaction| Transaction.new(transaction) }
  end

  def self.all()
    sql = "SELECT * FROM categories"
    results = SqlRunner.run(sql)
    return results.map { |category| Category.new(category) }
  end

  def self.find(id)
    sql = "SELECT * FROM categories WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)
    return Category.new(result[0])
  end

  def self.find_name(name)
    sql = "SELECT * FROM categories WHERE name = $1"
    values = [name]
    result = SqlRunner.run(sql, values)
    return Category.new(result[0])
  end

  def self.delete_all()
    sql = "DELETE FROM categories"
    SqlRunner.run(sql)
  end

end
