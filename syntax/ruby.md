# Use conditional assignment instead of conditional
```ruby
first_resort = {}
next_resort = {something: 'value'}

# All of the following produce the same result

result = first_resort[:something]
result ||= next_resort[:something]

result = next_resort[:something]
result = first_resort[:something] if first_resort[:something]

result = first_resort[:something] || next_resort[:something]
```
# Square brakcets is a method
```ruby
hash = { hello: "world" }
hash.try([], :hello)
```
# Delegate missing methods
```ruby
class Person
  def first_name
  end

  def method_missing(method_name, *args, &block)
    # What to do if the requester calls an undefined method of Person.
  end
end
```