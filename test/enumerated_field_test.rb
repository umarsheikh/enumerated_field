require File.dirname(__FILE__) + '/test_helper'

class Apple
  include EnumeratedField

  attr_accessor :color, :kind
  
  enum_field :color, [['Red', :red], ['Green', :green]]
  enum_field :kind, [['Fuji Apple', :fuji], ['Delicious Red Apple', :delicious]]

  def initialize(color, kind)
    self.color = color
    self.kind = kind
  end
  
end

class EnumeratedFieldTest < Test::Unit::TestCase

  def test_color_display
    apple = Apple.new(:red, :fuji)
    assert_equal apple.color_display, 'Red'
  end

  def test_color_display_for
    apple = Apple.new(:red, :fuji)
    assert_equal apple.color_display_for(:green), 'Green'    
  end

  def test_two_enum_fields_in_one_class
    apple = Apple.new(:green, :delicious)
    assert_equal apple.color_display, 'Green'
    assert_equal apple.kind_display, 'Delicious Red Apple'
  end

  def test_question_methods
    apple = Apple.new(:green, :delicious)
    assert apple.color_green?
    assert !apple.color_red?
    assert apple.kind_delicious?
    assert !apple.kind_fuji?
  end

  def test_values_without_first_option
    apple = Apple.new(:red, :fuji)
    assert_equal apple.color_values.length, 2
  end

  def test_values_with_first_option
    apple = Apple.new(:red, :fuji)
    assert_equal apple.color_values(:first_option => "Select Color").length, 3
  end

end