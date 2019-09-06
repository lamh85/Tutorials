# Membership - Technical Design

## Super basic overview

Membership is a contract where two parties trade goods:
* The USER gives money
* The APP allows access

*NOTE* - Focus on the messages and tasks rather than determining the actors, objects, classes, etc.

## Event Types

**The Whole Cycle**
* Registration
* [Async Events]
  * New Billing Period Starts
    * Invoice created
  * [Changes to Contract  - Possible reasons for changing the agreemnt in the contract]
    * [SELLER] Tier change (This is both reactive and independent)
    * User purchases or removes a feature
    * User changes billing period interval
* [Something causes cancellation]
  * Failed SCA
  * User requested cancellation
* Membership Expires

## Event-Handling Flows

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

STRIPE ends the billing period

STRIPE charges the credit card
  * Need price of the product
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
* Same process as registration

**Updating a seller tier**

APP is notified of the time
* some buffer time before the billing period end

APP determines the tier
* User's Amazon orders

APP updates the plan
* Price
* Name of the plan
* Same process as registration

**User accesses the app**

USER requests to open a webpage
* Find the user
* Does the plan include access to that page?
