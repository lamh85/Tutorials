# Low-level OOP

```ruby
Class.new.class == Object.class # => true
```

Instance methods actually belong to the class, not the instance:

```ruby
String.new.methods == String.instance_methods #=> true
```

## `prepend` vs `include`

```ruby
module SomeModule
  def some_method
    "I am from module"
  end
end

class WillInclude
  include SomeModule

  # => "I am from class"
  def some_method
    "I am from class"
  end
end

class WillPrepend
  prepend SomeModule

  # => "I am form module"
  def some_method
    "I am from class"
  end
end
```

# Monkey Patching

```ruby
class MyClass
  def my_method
    "original my_method()"
  end

  def another_method
    my_method
  end
end

module MyClassRefinement
  refine MyClass do
    def my_method
      "refined my_method()"
    end
  end
end

using MyClassRefinement
MyClass.new.my_method # => "refined my_method()"
MyClass.new.another_method # => "original my_method()"
```

A superclass has ancestrial messages/methods.



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