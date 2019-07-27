# Patterns

**Main characteristic of this pattern -** The superclass only calls the output. It has no other method.

**Why do this?**
* Prefer composition over inheritance.
* Fewer methods in the super class facilitates:
  * Open/Closed Principle.
  * Liskov Substitution Principle.

## Strategy
```ruby
class Cat
  def initialize(breed)
    @breed = breed
    @emotion = "something that came from Cat class"
  end

  # The superclass only contains the interface,
  # and not the computation of the output
  def meow
    @breed.meow(@emotion)
  end
end

class MaineCoon < Cat
  def meow(emotion)
    # given @emotion, create the output
  end

  # More methods
end

class ScottishFold < Cat
  def meow(emotion)
    # given @emotion, create the output
  end

  # More methods
end

# The "context": the act of calling the strategy's superclass
mc = MaineCoon.new
mc.meow
```

## Include vs Extend
http://www.railstips.org/blog/archives/2009/05/15/include-vs-extend-in-ruby/
```ruby
module IncludeMe
  def call_include
    puts 'I am from IncludeMe'
  end
end

module ExtendMe
  def call_extend
    puts 'I am from ExtendMe'
  end
end

class Parent
  # Module's methods are imported as instance methods
  include IncludeMe

  # Module's methods are imported as class methods
  extend ExtendMe
end

class Child < Parent
end
```
## Hooks
```ruby
class Ancestor
  def total
    [ *items, *local_items ]
  end

  def items
    [ 'the og' ]
  end
end

class Descendant < Ancestor
  def local_items
    [ 'another thing' ]
  end
  
  # Therefore, can call `total` to get the class' and superclass' list.
end

class SubDescendant < Descendant
  # Not good because need to call `super`, which is a sign of dependency:
  # It knows that some array items exist in the super class, therefore call `super`
  def local_items
    [ *super, 'another another thing' ]
  end
end
```


## Composition with Duck Typing
```ruby
class Hobby
  attr_reader :name
  
  def initialize(name:)
    @name = name
  end
end

class Exercise < Hobby
end

class DrugHobby < Hobby
end

# A Hobbies has many Hobby
class Hobbies
  def initialize(hobbies)
    @hobbies = hobbies
  end
end

# A Person has one Hobbies
class Person
  def initialize(name:, hobbies:)
    @name = name
    @hobbies = hobbies
  end
end

lift_weights = Exercise.new(name: 'lift weights')
smoke = DrugHobby.new(name: 'smoke')
strange_hobbies = Hobbiew.new([lift_weights, smoke])
some_guy = Person(name: 'John Doe', hobbies: strange_hobbies)
```


## Self Instantiation

```ruby
class Api
  def self.run(args)
    new(args).real_run
  end

  def initialize(args)
  end

  def real_run
  end
end

Api.run(some_args)
```

```
RSpec.describe "Making it yield arguments" do
  it "yields the provided args" do
    dbl = double
    # and_yield replaces the real arguments with custom arguments when the stubbed method is called.
    # EG: When method `foo` is called, ensure that arguments 2,3 become the arguments.
    allow(dbl).to receive(:foo).and_yield(2, 3)

    x = y = nil
    dbl.foo { |a, b| x, y = a, b }
    expect(x).to eq(2)
    expect(y).to eq(3)
  end
end
```


## Chain of Responsibility
https://medium.com/kkempin/chain-of-responsibility-design-pattern-in-ruby-e0b756d4bb3b

```ruby
class Policy
  attr_reader :successor

  def initialize(successor=nil)
    @successor = successor
  end

  def check_access(controller, user)
    if policy_matches_controller?(controller)
      return process_checking_access(controller, user)
    elsif successor
      successor.check_access(controller, user)
    else
      raise_no_policy(controller)
    end
  end

  def raise_no_policy(controller)
    raise "No policy found for #{controller}"
  end

  def process_checking_access(controller, user)
    raise 'not implemented'
  end

  protected
  def policy_matches_controller?(controller)
    controller.to_s == self.class.to_s.gsub('Policy', '')
  end
end

class RegistrationControllerPolicy < Policy
  def process_checking_access(controller, user)
    user.role == 'guest'
  end
end

class ProfileControllerPolicy < Policy
  def process_checking_access(controller, user)
    ['internal_user', 'admin'].include?(user.role)
  end
end

class LogsControllerPolicy < Policy
  def process_checking_access(controller, user)
    user.role == 'admin'
  end
end


user = User.new('admin')

policy = LogsControllerPolicy.new(
  ProfileControllerPolicy.new(
    RegistrationControllerPolicy.new()
  )
)

puts policy.check_access(ProfileController, user)
```


# Statements
## Use conditional assignment instead of conditional
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
## Square brakcets is a method
```ruby
hash = { hello: "world" }
hash.try([], :hello)
```
## Delegate missing methods
```ruby
class Person
  def first_name
  end

  def method_missing(method_name, *args, &block)
    # What to do if the requester calls an undefined method of Person.
  end
end
```