# Pointing

# Splitting Stories

RULE OF THUMB - Break things down based on testable units.

## Past examples

All repos
* If one aspect of the feature is more complex than the other, then isolate the complex portion of the feature. EG: a webform that is straightforward except one portion has complex UI.

Client side
* Sorting functionality
* Pagination functionality
* State structure in the reducer
* Render: loading state, empty state, list
* Actions
  * GET index
  * GET show
  * PATCH + re-render
  * DELETE + re-render

API
* Migration
* Model
* Controller and route

# What to work on first