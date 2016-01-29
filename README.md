January 28th:

MRCAV
* Model Routes Controller Actions Views

Strong params
  * How it works and why it's important
  * Prevents mass assignment to data base
  * Sanitizes user input coming from ubiquitous forms
  * Limits the type of data that can be entered
  * Uses a private method to require and permit information.
  * Private methods are not accessible from the web

  https://github.com/rails/strong_parameters
  * Explains strong parameters and the process of implementation
  * Practical overview

  http://blog.trackets.com/2013/08/17/strong-parameters-by-example.html
  * More in depth explanation
  * Outlines details of association with ActionController::Parameters
  and how require and permit methods actually work.

Data entry validations
  * Applied validates method to product model
  * Used 'presence' and 'numericality' helpers
  * Validate that name and description values are present
  * Validate that price_in_cents is a number and an integer

  http://api.rubyonrails.org/classes/ActiveModel/Validations/ClassMethods.html#method-i-validates
  * Explains validates method

  http://guides.rubyonrails.org/active_record_validations.html
  * Explains validates syntax and helpers 'presence' and 'numericality'
___

_path VS _url

 You should always use _url for redirects and _path for hyperlinks unless you have a good reason not to do so.

* _path returns a relative path e.g /products
  * _path are generally used in views because hrefs are implicitly linked to the current URL.   
* _url returns an absolute path e.g HTTP://localhost:3000/products
  * You need to use an absolute URI when linking to an SSL site from a non-SSL site, and vice versa.
  * You need to use an absolute URI when creating a redirect (e.g. with redirect_to.)

  ___

redirect_to VS render

* 'render' tells your controller to render a view without passing any data (say, from a form) to the next controller action.

* 'redirect_to' does a 302 page redirect, passing data (say, from a form) to either a controller action on your web app, or an external app (ex: google, facebook, a web article you liked, etc)

We use render in a controller when we want to respond within the current request, and redirect_to when we want to spawn a new request.
____
