# Membership - Technical Design

## UML

*NOTE* - Focus on the messages and tasks rather than determining the actors, objects, classes, etc.

**Registraiton**

USER visits APP. This is a selection of a product:
* Charging frequency
* Price
  * Has discount?
    * Amount
    * Duration
* Accessible features

APP renders product information

USER submits info
* Credit card info
* Profile
* Auth

APP validates
* unique email?
* password strength
* credit card is approved by the card issuer and address validation rules

**New Billing Period**

TIME reaches a unix time

STRIPE is notified of the time

STRIPE charges the credit card
* price
