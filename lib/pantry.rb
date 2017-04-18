require 'pry'

class Pantry
  attr_reader :stock, :shopping_list

  def initialize
    @stock = {}
    @shopping_list = {}
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

  def add_to_shopping_list(recipe)
    recipe.ingredients.each_pair do |k,v|
      @shopping_list[k] = v
    end
  end

  def print_shopping_list
    shopping_list.each_pair do |k, v|
      p "#{k.to_s} #{v.to_s}"
    end
  end


end
