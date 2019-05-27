# Rather than creating subclasses of a class, why not do this?
class ParentClass
  def some_attr(flavour)
    if flavour == "vanilla"
      "yum"
    else
      "sure, why not?"
    end
  end
end
# Answers:
#   Need to keep adding to the conditional. If forgot to update, then it will return "else", which is not always desired.
#   Both "if" and "else" could contain duplicate code.
#   Even worse if each of the 2 conditions touch other attributes like this:

class ParentClass
  attr_accessor :arg1, :arg2

  def initialize(arg1, arg2)
    @arg1 = arg1
    @arg2 = arg2
  end

  def some_attr(flavour)
    # Change the requester's intended attributes with little transparency.
    if flavour == "vanilla"
      @arg1 = @arg1 + 1
    else
      @arg2 = @arg2 + 1
    end
  end
end

# The above is another version of anit-duck typing. The difference is that the `case` or `if` block is in the service class rather than the requester class.

# It is better to start with duplicated code across the subclasses, then promote up to the superclass. The alternative, start at the top and then promote down, creates an unreliable hierarchy: concrete attributes are accidentally left behind in the superclass, and applied to all subclasses.

# Given this hierarchy:
class Item
end
class Coin < Item
end
class Mushroom < Item
end
# If the hierarchy starts out with too many concrete attributes in Item, then the clients of the hierarchy will know too much about Coin and Mushroom.

# Example of too much centralization in the superclass:
class Organism
  def some_list
    ["apple", "banana", "grape"]
  end
end
class Human < Organism
  def some_list
    super.select do |item| item != "banana" end
  end
end
class Dog < Organism
  def some_list
    [*super, "mango"]
  end
end
# Problem: the subclasses know too much about the superclass:
  # It knows that the default value is an array.
  # It knows that there is a method called some_list.

# Raise an error if a subclass doesn't have a method, but is required.
# Use this pattern if the superclass does not have a default, but its subclasses must have the method.
class Organism
  def some_method
    raise NotImplementedError, "This #{self.class} cannot respond to:"
  end
end

# Pitfall: Making this required in all subclasses:
def initialize
  # some code
  
  super
end
# Why? Adding a new subclass could forget to call super. Then the default attributes won't be set.

# BIG TAKEAWAY: `super` is always a dependency

# How to avoid using `super` in initialize:
class Organism
  def initialize
  end
end
class Human < Organism
  def post_initialize
    # everything executed here occures after Organism#initialize
  end
end

# How to avoid depending on the superclass' method:

class Organism
  def base_list
    {
      some_key: "some_value",
      **enlarged_list
    }
  end

  def enlarged_list
    {}
  end
end
class Human < Organism
  def enlarged_list
    {
      another_key: "another_value"
    }
  end
end

