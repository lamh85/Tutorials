# Patterns

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

# RSpec Yield
# -----------
# https://relishapp.com/rspec/rspec-mocks/v/3-8/docs/configuring-responses/yielding

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