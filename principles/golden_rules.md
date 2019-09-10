# Golden Rules

AKA - Common themes from reading:
* Practical OOP Design in Ruby
* Design Patterns in Ruby

## The Rules

**Dependency** - This is the cause of almost all costs.

**Cost** - Ask the cost of changing your written code in the future. The more code that needs to be changed, the more costly.

**Dependency is easy to create** - Uttering is sufficient to create dependency.
* If a block of code merely implements something, that implementation is dependency.
* For example:
```ruby
# Just by mentioning .id, do_something assumes that user has a method named id.
def do_something(user)
  puts user.id
end
```

**Anticipate now or wait later?**

**Compare with real-life relationships** - For example:
* has a/some (contains)
* is a (sub-type)
* aggregate
* checklist
* sender-receiver
* client-service
* middle-man
* gate keeper
* bouncer