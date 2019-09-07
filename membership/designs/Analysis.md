# Methodology

Use these flows as examples. They represent very distant events of a user journey, and represent the different actors: user, Stripe, and app.
* USER registers
* STRIPE starts new billing period
* APP changes Seller tier (This is both reactive and independent)
* USER requests cancellation

# Findings

An event can trigger another event.
* But the second event should be sent from the web app or Stripe.
* EG:
  * Event 1: New billing period starts
  * Event 2: Change Seller plan tier
  * Event 3: Stripe emits event: `subscription` updated.

## Common Themes

Everything is triggered by an event

Tracking for Marketing and Finance

Updating state. Sources of truth:
* Stripe
  * Billing period: transitioning, issuing invoice
  * Credit card
* User
  * Pesonal and contact. EG: name, email, etc.
* Web app database
  * Feature access

# Possible New Flow

## Criteria

Wherever possible, use duck typing instead of conditional.

Follow SOLID and advice re: using correct OOP design patterns.

## Flow

* Event happens
* `StripeEvent.configure` or some class chooses the correct handler
* Run handler
  * Update Membership
  * Update Stripe object
  * Update Metrics