Some languages and libraries keep immutable rules in singletons. EG:
* `Math` in Javascript
* `ActiveSupport` in Rails

Can our membership system do the same?

What qualifies for a singleton:
* concepts that should never be changed via instantiation
