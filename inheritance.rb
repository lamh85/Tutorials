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