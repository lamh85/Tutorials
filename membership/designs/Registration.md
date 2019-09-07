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

# Describe What the Class is in Layman

Why register? (The more base answers, the better)
* To confirm that both parties have agreed.

It is a list of operations.
* Each operation records things.
* Some operations need the previous one to finish.

It must be able to roll back (to some extent).
* Must identify which stage caused the failure.

It responds to an event.

Keeps the state updated so that Stripe and the app can do its job (just like many other membership systems).

# Membership abstract players

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

The contract model:
* User
  * Personal information
* Agreement
  * Billing cycle
    * Trial
  * Price
  * Features
  * Discounts (deals, perks, bonuses, etc) - Array of agreements
    * Agreement 1
    * Agreement 2
    * etc...

# Current Registration Flow

## Ideal Metaphors
* Coordinator of tasks
* Keep states updated

## Ideal Responsibility
* Runs everything required for registration
* Defines the variables needed for the new objects: `membership` and `subscription`

## Flow
* Get Avalara metadata
* Create Stripe customer
* [conditional] Based on whether params contains `mt`/`et`/`ct`, run the correct service object for purchases.
* Purchase service object specific to `mt`/`et`/`ct` (Using `mt` as an example)
  * Define attribute values for `membership` and `subscription`
  * Create membership
  * Define metadata 
  * Define `request_origin`
  * Generate `subscription` config using metadata and `request_origin`
  * Merge more data into the config
  * Create the `subscription` with the config

## Analysis of flow
* Can we just let the concrete classes do their own attribute generation? EG: let the `subscription`-creating class determine the trial?

# Current Roll Plan Flow

Schedule

Run job
* Scope to find the users

For each user
* 