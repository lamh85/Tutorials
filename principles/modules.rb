# Avoid this:
# -----------
# I want to know if my_var is burnable?
my_var = "something"
BurnUtils.burnable?(my_var)
# This is bad because my_var is already an instance of String class. Why can't we use a method from String to know `burnable?` The above has too much dependency: we must *know* that class BurnUtils exists.

