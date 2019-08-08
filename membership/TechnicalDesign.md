# Membership - Technical Design

## UML

*NOTE* - Focus on the messages and tasks rather than determining the actors, objects, classes, etc.

**Registraiton**

USER visits APP.
* Product's URL

APP tells the USER about the product

* Is the public available to the public?
* Charging frequency
* Price
  * Has discount?
    * Amount
    * Duration
* Accessible features
* Roll plan

USER submits info
* Credit card info
* Profile
* Auth

APP validates
* unique email?
* password strength
* credit card is approved by the card issuer and address validation rules

**Change credit card**

USER submits credit card info
* credit card info

**New Billing Period**

STRIPE is notified of the time
* billing period end

STRIPE charges the credit card
* price
* credit card info

STRIPE updates the billing period
* current period's start
* current period's end

**Discount rolls into new plan**

APP/STRIPE is notified of the time
* billing period end

APP checks eligibility
* Is there a roll plan?
* Is it the end of the discount?

APP/STRIPE applies the new plan
