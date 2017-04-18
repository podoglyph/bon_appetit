require './lib/pantry'
require './lib/recipe'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'

class PantryTest < Minitest::Test

  def test_it_exists
    pantry = Pantry.new

    assert_instance_of Pantry, pantry
  end

  def test_pantry_stock
    pantry = Pantry.new

    assert_equal Hash.new, pantry.stock
  end

  def test_stock_check
    pantry = Pantry.new

    assert_equal 0, pantry.stock_check("Cheese")
  end

  def test_restock
    pantry = Pantry.new
    pantry.restock("Cheese", 10)

    assert_equal 10, pantry.stock_check("Cheese")
  end

  def test_restock_additive_method
    pantry = Pantry.new
    pantry.restock("Cheese", 10)
    assert_equal 10, pantry.stock_check("Cheese")

    pantry.restock("Cheese", 20)
    assert_equal 30, pantry.stock_check("Cheese")
  end

  def test_pantry_can_get_recipe
    pantry = Pantry.new
    r = Recipe.new("Cheese Pizza")
    assert_equal ({}), r.ingredients

    r.add_ingredient("Cheese", 20)
    r.add_ingredient("Flour", 20)
    assert_equal ({"Cheese"=>20, "Flour"=>20}), r.ingredients

    assert_equal ({}), pantry.shopping_list

    assert_equal ({"Cheese"=>20, "Flour"=>20}), pantry.add_to_shopping_list(r)

    assert_equal ({"Cheese" => 20, "Flour" => 20}), pantry.shopping_list
  end

  def test_adding_second_recipe
    pantry = Pantry.new
    r = Recipe.new("Cheese Pizza")
    r.add_ingredient("Cheese", 20)
    r.add_ingredient("Flour", 20)
    pantry.add_to_shopping_list(r)

    r = Recipe.new("Spaghetti")
    r.add_ingredient("Noodles", 10)
    r.add_ingredient("Sauce", 10)
    r.add_ingredient("Cheese", 5)
    pantry.add_to_shopping_list(r)

    assert_equal ({"Cheese" => 20, "Flour" => 20, "Noodles" => 10, "Sauce" => 10, "Cheese" => 5}), pantry.shopping_list
  end

  def test_printing_shopping_list
    pantry = Pantry.new
    r = Recipe.new("Cheese Pizza")
    r.add_ingredient("Cheese", 20)
    r.add_ingredient("Flour", 20)
    pantry.add_to_shopping_list(r)

    r = Recipe.new("Spaghetti")
    r.add_ingredient("Noodles", 10)
    r.add_ingredient("Sauce", 10)
    r.add_ingredient("Cheese", 5)
    pantry.add_to_shopping_list(r)

    #assert_equal "* Cheese: 20\n* Flour: 20\n* Noodles: 10\n* Sauce: 10", pantry.print_shopping_list
  end

  def test_add_to_cookbook
    pantry = Pantry.new

    r1 = Recipe.new("Cheese Pizza")
    r1.add_ingredient("Cheese", 20)
    r1.add_ingredient("Flour", 20)

    r2 = Recipe.new("Pickles")
    r2.add_ingredient("Brine", 10)
    r2.add_ingredient("Cucumbers", 30)

    r3 = Recipe.new("Peanuts")
    r3.add_ingredient("Raw nuts", 10)
    r3.add_ingredient("Salt", 10)

    pantry.add_to_cookbook(r1)
    pantry.add_to_cookbook(r2)
    pantry.add_to_cookbook(r3)

    assert_equal ({"Cheese"=>20, "Flour"=>20, "Brine"=>10, "Cucumbers"=>30, "Raw nuts"=>10, "Salt"=>10}), pantry.cookbook

    pantry.restock("Cheese", 10)
    pantry.restock("Flour", 20)
    pantry.restock("Brine", 40)
    pantry.restock("Cucumbers", 40)
    pantry.restock("Raw nuts", 20)
    pantry.restock("Salt", 20)

    assert_equal ({"Cheese"=>10, "Flour"=>20, "Brine"=>40, "Cucumbers"=>40, "Raw nuts"=>20, "Salt"=>20}), pantry.stock
  end

  def test_what_can_i_make
    pantry = Pantry.new
    r1 = Recipe.new("Cheese Pizza")
    r1.add_ingredient("Cheese", 20)
    r1.add_ingredient("Flour", 20)
    r2 = Recipe.new("Pickles")
    r2.add_ingredient("Brine", 10)
    r2.add_ingredient("Cucumbers", 30)
    r3 = Recipe.new("Peanuts")
    r3.add_ingredient("Raw nuts", 10)
    r3.add_ingredient("Salt", 10)
    pantry.add_to_cookbook(r1)
    pantry.add_to_cookbook(r2)
    pantry.add_to_cookbook(r3)
    pantry.restock("Cheese", 10)
    pantry.restock("Flour", 20)
    pantry.restock("Brine", 40)
    pantry.restock("Cucumbers", 40)
    pantry.restock("Raw nuts", 20)
    pantry.restock("Salt", 20)

    assert_equal ["Pickles", "Peanuts"], pantry.what_can_i_make
  end

end
