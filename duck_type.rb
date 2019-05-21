# Goal:
# The requester shouldn't be concerned with the service's type.
# The service's interface should be flexible to a diversity of clients.

# Problem: `def reheat` assumes that the service can reheat_food
class Customer
  def reheat(some_object)
    some_object.reheat_food
  end
end

# Opposite of duck typing:
# The client knows too much about the services
class Customer
  def order(service_provider)
    provider_class = service_provider.class

    case provider_class
    when CellProvider
      service_provider.contact_by_phone
    when Restaurant
      service_provider.tell_waiter
    when ComputerStore
      service_provider.tell_cashier
    end
  end
end

# Good example of duck-typing: sub-models
# ---
# The client:
class Customer
  def purchase(plan)
    plan.purchase
  end
end
# The parent model. It ensures that all sub-models could receive requests from the client
class PlanType
  def purchase
  end
end
# Sub-model
class MembershipType < PlanType
end
# Sub-model
class ExtensionType < PlanType
end