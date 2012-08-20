require './attribute_validated.rb'

class Example
  include AttributeValidated

  attr_validated :weight do |new_value|
    new_value < 50
  end
end