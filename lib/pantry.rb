require 'pry'
class Pantry
  attr_reader :stock

  def initialize
    @stock = {}
  end

  def stock_check(item)
    return 0 if stock.has_key?(item) == false

    stock[item]
  end

  def restock(item, num)
    current_num = @stock[item]
    @stock[item] = num
  end
end
