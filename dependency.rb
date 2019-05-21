# Depend more on the permanent, depend less on the temporary.
# ---

# This ...
def some_method(user)
  # Safe to assume that the User model will always have an ID.
  id = user.id
end
# is better than this
def some_method(user)
  # Not all apps keep track of IP addresses. It depends on the business logic's requirements.
  ip_address = user.ip_address
end

# Always better
def some_method(user_id)
end