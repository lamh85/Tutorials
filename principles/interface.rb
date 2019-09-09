# WHAT vs HOW
# ============
# The requester should perform the "what" rather than "how".
# "What" ensures the requester to know as little as possible.

# How - NOT preferable
class Customer
  def prepare_ingredients
    kitchen.prepare_ingredients
  end

  def cook
    kitchen.cook
  end

  def plate_ingredients
    kitchen.plate_ingredients
  end
end

# What - Preferable
class Customer
  def order_food
    kitchen.order_food
  end
end
class Kitchen
  def order_food
    prepare_ingredients
    cook
    plate_ingredients
  end
end

# Law of Demeter
# ===
# "only talk to your immediate neighbours"
# Good:
user.membership
# Bad:
user.membership.change_plan
# Why is this bad?
# The root object's logic shouldn't be forced to change just because the INDIRECT object changes.
# EG: In above, `user` model shouldn't change just because `stripe_plan` model changes.

# Reasonable exceptions
# * You're GETTING rather than SETTING. EG:
user.membership.created_at
# * You're depending on objects that rarely change. Or all the intermediate objects are the same class. EG:
hash.keys.sort.join # Enumerable . Enumerable . Enumerable . String

# What violation implies:
# You might need to create a new interface to prevent the long chaining.

# EG:
customer.kitchen.reheat_food
# could instead be this:
customer.stop_eating_and_complain_to_kitchen
# because the customer shouldn't know how to implement the solution.

# Messages vs Objects
# ===

# When planning, focus on defining the messages first, THEN plan the objects.
# If you do the reverse, you will limit yourself. For example, it will preclude duck-typing.