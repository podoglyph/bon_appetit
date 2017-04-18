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
    if stock_check(item) == 0
      @stock[item] = num
    else
      current_num = @stock[item]
      total_addition = current_num + num
      @stock[item] = total_addition
    end
  end
end
