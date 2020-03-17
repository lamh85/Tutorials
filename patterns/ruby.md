# Domain Specific Language

Here is a script that depends on a fictional DSL.

```ruby
# Filename: my_journey.nav

start(0, 0)
move("up", 3)
move("right", 3)
get_position
```


Here is the DSL that takes the above script as an input.

```ruby
class GridNavigator
  attr_accessor :position

  def self.call(dsl_input)
    new(dsl_input).run_dsl_input
  end

  def initialize(dsl_input)
    @dsl_input = dsl_input
    @position = { 0, 0 }
  end

  def run_dsl_input
    eval(dsl_input)
  end

  private

  def start(x:, y:)
    @position = { x: x, y: y }
  end

  def get_position
    @position
  end

  def move(direction:, increment:)
    if ['up', 'right'].include? direction
      normalized_size = increment.abs
    else
      normalized_size = (increment.abs * -1)
    end

    if ['up', 'down'].include? direction
      change_position(0, normalized_size)
    else
      change_position(normalized_size, 0)
    end
  end

  def change_position(increment_x:, increment_y:)
    @position = {
      x: @position[:x] + increment_x,
      y: @position[:y] + increment_y
    }
  end
end
```

Run the script that uses the DSL:
```ruby
GridNavigator.call(File.read('my_journey.nav'))
```

# Ghost Method

## Infinit Loop

```ruby
class RandomNumberGenerator
  def method_missing(name, *args)
    3.times do
      number = rand(10)
    end
    # Infinite loop starts below
    puts "The number is #{number}"
  end
end
```

### Cause
1. The developer thought that `puts` would call the `number` that was defined in the loop. But he forgot that `puts`' line of code has no access to that variable.
2. The variable is undefined. Therefore, Ruby looks for the method `number` in the class.
3. Since Ruby cannot find the method, it calls `method_missing`.
4. `method_missing` runs another loop, which is steps 1 to 3 above.

### Main Lessons
* Using only `method_missing` means that you want all method names to be valid. But is that what you really want? Sometimes you really do want a `NoMethodError`.
* Always reference `BasicObject`'s `method_missing` as a fallback. Without it, your class will define all method names as valid.

## Name Clash

```ruby
class CustomString < String
  def method_missing
  end
end

# calls String#to_s instead of CustomString#to_s
CustomString.new.to_s 
```

### Solution: Inherit from "blank slate"

```ruby
class CustomString < BasicObject
  def method_missing
  end
end

# calls CustomString#to_s
CustomString.new.to_s
```

# Membership Task Runner

This is a pattern that I created at work.

```ruby
module Memberships
  module Persisters
    class InAppResearchPurchase
      attr_reader :user,
                  :current_product,
                  :new_product

      attr_accessor :response_message,
                    :response_code

      def run
        new(params).run_tasks
      end

      def initialize(params)
      end

      private

      def run_tasks
        error_response = {
          response_message: response_message,
          response_code: response_code
        }

        return error_response if
          !new_product_exists? ||
          !sift_authorized? ||
          !valid_product_change?

        persist
        track_metrics

        { response_code: 200 }
      end

      def new_product_exists?
        return true if found

        @response_message = "Product not found"
        @response_code = 404
        return false
      end

      def sift_authorized?
        # same pattern as new_product_exists?
      end

      def valid_product_change?
        # same pattern as new_product_exists?
      end

      def persist
      end

      def track_metrics
      end
    end
  end
end
```

# Singleton

```ruby
def SomeClass
  # Prevent instantiation
  private_class_method :new
end
```

Easy conversion to Singleton
```ruby
def SomeClass
  include Singleton
end
```

Can use modules instead of classes to create singleton because modules can't be instantiate.

BUT, you can clone it, then re-define it:
```ruby
SomeModule.clone
```

# Decorator

**Main Feature**
* A decorator's output can be re-used for a different decorator.
* Therefore, all decorators input and outplut classes should be the same.

```ruby
class Decorator
  def call(content)
    new(content).decorate
  end

  def initialize(content)
    @content = content
  end

  def decorate
    raise 'Expected a "decorate" method, but found none.'
  end
end

class TimeStamper < Decorator
  def decorate
  end
end

class CaseFixer < Decorator
  def decorate
  end
end

# Must be able to use the above decorators in any order.
```

# Deocrators Replace This

```ruby
class Decorator
  def initialize(content)
    @content = content
  end

  # All these methods are accessible from outsie.

  def print_with_timestamps
  end

  def print_with_all_caps
  end

  def print_in_xml
  end
end
```

# Proxy without mirror every target's method

```ruby
def SomeProxy
  def initialize(target_class)
    @target_class = target_class
  end

  def method_missing(method, *args)
    # This is better than writing a proxy for every @target_class' methods
    @target_class.send(method, *args)
  end
end
```

**Pitfalls**
* If wrapped around a standard-library class (EG: `String`), then you `method_missing` will intercept common methods like `.to_s`.
* This does NOT update `.respond_to?` method. If you run `some_proxy.respond_to?`, it will return false.

# Virtual Proxy

Do not create something expensive until absolutely necessary.

EG: Don't do an API call to Stripe until needed.

# Remote Proxy

A middleman that deals with HTTP communication between the client and the target class.

# Protection Proxy

```ruby
class ProductTrackerProxy
  def initialize(tracker)
    @tracker = tracker
  end

  def track_product
    return unless has_access?
    @tracker.track_product
  end

  private

  def has_access?
  end
end

class ProductTracker
  def track_product
  end
end
```

# Adapter via Modification

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

# Adapter

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

# Command

Operations to consider:
* Undo - Is the operation really undo-able? What is required for making it possible? EG: store the file before deletion so that the deletion can be undone.
* Redo - Same as above. Do you need to temporarily save the payload and event type?

Other key notes
* Can create a list of commands and run them.
* Can undo the whole list by running all their "undo"s in reverse order.

# External Iterator

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

# Internal Iterator

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

# Composite

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

# Observer

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

# Strategy Pattern

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

# Substitute Strategy Option with a Proc

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

# Include vs Extend
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
# Hooks
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


# Composition with Duck Typing
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


# Self Instantiation

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

# Yield in RSPEC

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


# Chain of Responsibility
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