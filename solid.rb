# Single responsibility principle
=begin
  Sources:
  https://subvisual.co/blog/posts/19-solid-principles-in-ruby/

=end

# Open/closed principle
# ---------------------
# open to extension, closed to modification
# IE: Open to class inheritance, but base class is closed to modification
# Why - The most parent class is meant to be the most general, abstract template. The sub-classes are more specific templates. The parent class must be flexible enough to accommodate more specific situations.

# Bad
class Report
  def body
     generate_reporty_stuff
  end

  def print
     body.to_json # Not flexible enough for extension
  end
end

# Good
class Report
  def body
     generate_reporty_stuff
  end

  def print(formatter: JSONFormatter.new)
     formatter.format body
  end
end

# Liskov substitution
# -------------------
# the sub class must be able to replace the parent class
# Why - Multiple clients that call these classes can consistently assume what methods are defined and return the same datatype. See this answer: https://softwareengineering.stackexchange.com/a/170229

class Parent
  def speak
    "some coherent sentence"
  end
end

# Bad
class Child < Parent
  # Bad: Returns a datatype that is different from parent.
  def speak
    5
  end

  def walk
    "walking"
  end
end

# Good
class Child < Parent
  def speak
    "some nonsense"
  end
end

# Interface segregation
# ---------------------
# An interface must be wholly used by its client.
# In other words, there cannot be parts of the interface that are exclusively relevant to Client A, and some exclusively relevant to Client B.
# "Clients should not be forced to depend upon interfaces that they don't use."
#   Source: http://rubyblog.pro/2017/07/solid-interface-segregation-principle
# Why - Same reason for Single Responsibility Principle. Modifying the processing for Client A could adversely impact the service provided for Client B.
# Why - See above: "Clients should not be forced to depend upon interfaces that they don't use." You could end up adding more requirements for a client's requests (EG: required arguments) just to satisfy the needs of another client.

# Bad
class Interface
  def run_for_client_a
  end

  def run_for_client_b
  end

  private

  # Some methods: some only used for Client A, some are only for Client B
end

# Bad
class Interface
  def run(should_log_results = false) # Bad because some clients never need this argument.
    # do some stuff...

    if should_log_results
      # log results
    end
  end
end

# Dependency inversion principle
# ------------------------------
# Depend on abstractions instead of details
# Why - Abstractions change less often than concrete classes. EG: Our users may want us to change the rendered data of an Amazon order, but the model of the order will never change.

# Bad
class UserModel
  def print_data # UserModel is the abstract. print_data is the concrete
    self.as_json
  end
end

# Good
class UserModel
  def print_data(format = :as_json)
    self.send(format.to_sym)
  end
end