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

January 29th

Tools:

HTML Codes for Symbols etc.
http://www.ascii.cl/htmlcodes.htm
* Use html ascii codes for cross platform compatibility.


6. Displaying price in dollars

http://betterexplained.com/articles/intermediate-rails-understanding-models-views-and-controllers/
* great MVC diagram.
* More in depth description of the role of each MRCAV element and what is happening at each step in the request response
 cycle.

sprintf

sprintf(format_string [, arguments...] ) → string Link

* Returns the string resulting from applying format_string to any additional arguments. Within the format string, any
characters other than format sequences are copied to the result.
* Used in the formatted_price method in the Product model, to for a 2 decimal place return.


7. Creating a user model, controller and view

Authentication

https://github.com/codahale/bcrypt-ruby
* bcrypt documentation

rails g model User email:string password_digest:string

* Must name the column where we are going to store user passwords password_disgest.

rails g controller users new create

* creates users controller with actions new and create

Rails.application.routes.draw do
  resources :products
  resources :users, only: [:new, :create]
end

* The only keyword restricts the routes to only the actions specified in the array. Instead of generating all 7 restful Routes

def create
  @user = User.new(user_params)

  if @user.save
    redirect_to products_url notice: "Signed Up!"
  else
    render :new
  end
end

Q: How does notice: work exactly?
* some how linked to the flash method? Yes, exactly.
A: redirect_to(options = {}, response_status_and_flash = {})
* flash messages when entering information from form after render or redirect_to. You can add anything to the flash message from anywhere in the controller as long as you use a key that the flash method knows about.
* pass a key that flash knows about in the response_status_and_flash = {} as shown above.


<%= form_for @user do |f| %>
* use <%= with form_for



Q: Error message code for Sign up form
* should I memorize this?
* where does .errors, .full_messages, come from exactly?
* search Active Model Errors, and Active Model Validations
  * seems like if you use validations in your model,
A: Review Active model errors methods. Can be called on any active model object.
