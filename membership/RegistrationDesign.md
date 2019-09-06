# Prerequisite

CREATE Stripe `product`
* represents the good/service that the `user` receives
* belongs to `plan`

CREATE Stripe `plan`
* has `product`

# Flow

Client sends to back-end:
* `user` profile
* credit card info
* Contract
  * price
  * frequency
  * product

## Sequence

[1] CREATE `user`
* Why first? So we can have a base reference in case anything fails. IE: for good UX.
* Associate with `membership` and `membership_type`

[2] CREATE Stripe `customer`
* belongs to `subscription`

[3] UPDATE `user`
* Persist `customer.id`

[A] CREATE Stripe `subscription`
* Must execute after [2]
* has `customer`
* has `plan`
* has `coupon`

UPDATE - See this drawing:
https://docs.google.com/document/d/1hbhTErbU3R9qi8iAUhKEmqwhxBYraplFRy3c7n9D3uo/edit

## Describe What the Class is in Layman

Why register? (The more base answers, the better)
* To confirm that both parties have agreed.

It is a list of operations.
* Each operation records things.
* Some operations need the previous one to finish.

It must be able to roll back (to some extent).
* Must identify which stage caused the failure.

It responds to an event.

Keeps the state updated so that Stripe and the app can do its job (just like many other membership systems).

## What if we model the registration based on a tangible metaphor?

Registration = confirmation of a contract

What is a contract?
* Two parties
* Both parties trade

What is the contract in this context?
* User gives:
  * Money every period
  * Variables: price, period size
* App gives:
  * Access