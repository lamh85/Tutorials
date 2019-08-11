# Patterns

## Adapter via Modification

Modify an existing class:

```ruby
class String
  def some_new_method
  end

  # Dangerous because this method already exists!
  def empty?
  end
end
```

Modify only the instance
```ruby
john = Person.new

class << john
  def some_method
  end
end

# Alternate syntax
def john.another_method
end
```

## Adapter

Why use it?
* Client wants to use a service. But the service is dependent on something that doesn't exist.

```ruby
class Car
  def add_engine(engine)
  end

  def start_engine
    engine.start
  end
end

class ToEngineConverter
  def initialize(not_an_engine)
    @not_an_engine = not_an_engine
  end

  # Create this method because class Car needs it.
  def start
    # Do something to @not_an_engine
    'starting engine...'
  end
end

engine = ToEngineConverter.new('not an engine')
car = Car.new(engine)
car.start_engine
```

## Command

Operations to consider:
* Undo - Is the operation really undo-able? What is required for making it possible? EG: store the file before deletion so that the deletion can be undone.
* Redo - Same as above. Do you need to temporarily save the payload and event type?

Other key notes
* Can create a list of commands and run them.
* Can undo the whole list by running all their "undo"s in reverse order.

## External Iterator

How is this different from internal iterator?
* You don't pass in a proc
* The client can interrupt the flow of the traversing because of above. But for internal ones, you just state the algorithm and let the iterator mindlessly run without question or interruption.

```ruby
class SomeIterator
  def initialize(array)
    @array = array
  end

  def push
  end

  def next_item
  end
end
```

## Internal Iterator

```ruby
def for_each_element(array)
  i = 0
  while i < array.length
    yield(array[i])
    i += 1
  end
end

a = [10, 20, 30]
for_each_element(a) {|element| puts("The element is #{element}")}
```

## Composite

```ruby
class Task
  # Whatever is common between composites and components.
end

module Composite
  attr_reader: :children

  def add_child
  end

  def remove_child
  end
end

class CodeReview << Task
  # Because it has child tasks
  include Composite
end

# This is a child of CodeReview, but it is still a task
class QA << Task
end
```

## Observer

**Main characteristics:**
* The subject (the observed) just emits events. But doesn't care who the observers are.
* The observer handles the received events.
* The subject has methods for adding more observers.

```ruby
# Ruby has this module in its standard library.
# The module below is different.
module Observable
  def add_observer(observer)
    observers << observer
  end

  def broadcast
    observers.each do |observer|
      observer.receive_notification(@notification_payload)
    end
  end
end

# See notes for Observable module
module Observer
  def receive_notification(notification_payload)
    @notification_handler.call(notification_payload)
  end
end

class SomeObservable
  include Observable

  def initialize(notification_payload)
    @notification_payload = notification_payload
  end

  def do_some_event
    # Notifying the observers should have zero dependency on
    # who the observers are. Nor should it know whether observers exist.
    # It should just notify.
    broadcast
  end
end

class SomeObserver
  include Observer

  def initialize(&notification_handler)
    @notification_handler = notification_handler
  end
end
```

## Strategy Pattern

**Main characteristic:** The superclass only calls the output. It has no other method.

**Why do this?**
* Prefer composition over inheritance.
* Fewer methods in the super class facilitates:
  * Open/Closed Principle.
  * Liskov Substitution Principle.

```ruby

# The strategy class
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

  # NO OTHER method
end

# A strategy option
class MaineCoon < Cat
  def meow(emotion)
    # given @emotion, create the output
  end

  # More methods
  # More methods
  # More methods
end

class ScottishFold < Cat
  def meow(emotion)
    # given @emotion, create the output
  end

  # More methods
  # More methods
  # More methods
end

# The "context": the act of calling the strategy's superclass
mc = MaineCoon.new
mc.meow
```

## Substitute Strategy Option with a Proc

This is only effective if the strategy object can fit inside one method. If so, then store it in side a proc.

```ruby
class Report
  def initialize(&config)
    @config = config
    @title = 'I am a title'
    @body = 'I am a body'
  end

  def render
    config.call(self)
  end
end

# A strategy option
# The 'context' argument is the 'self' in config.call(self)
some_format = lambda do |context|
  puts context.title
  puts '============'
  puts context.body
end
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

## Yield in RSPEC

```ruby
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