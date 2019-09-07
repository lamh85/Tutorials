STRIPE emits event `customer.subscription.updated`

Create event object wrapper

Is this a request for cancellation?
* do stuff

APP emits event via `StripeEvent`

Run `StripeWebhookHandler::Subscription::Updated`
* Do not run unless assocation with user
* Update DB's copy of `subscription`
* Update `membership` to reflect Stripe `Subscription`