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
See w3d5_jan29_2016.md for more notes
/Users/Macbook/Desktop/Bitmaker/Lessons/lesson_notes

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
* Use flash message keys with render or redirect_to. You can add anything to the flash message from anywhere in the controller as long as you use a key that the flash method knows about.
* key to the response_status_and_flash = {} as shown above.


<%= form_for @user do |f| %>
* use <%= with form_for

<% @user.errors.full_messages.each do |message| %>
* use <% (without equals sign) in this case!

Q: Error message code for Sign up form
* should I memorize this?
* where does .errors, .full_messages, come from exactly?
* search Active Model Errors, and Active Model Validations
  * seems like if you use validations in your model,
A: Review Active model errors methods. Can be called on any active model object.

8. Creating log in functionality

Sessions
* no need to create a model because there is nothing saved to a database when logging in.
* don't actually need the 'new' action in the sessions controller.

Q: Difference between form_for and form_tag?

A:

form_for
* prefers an active record object as it's first arg.
* easily creates a create or edit form
* Used when modifying or add an instance of a model.

form_tag
* best used for non model forms
* no model associated with a session
* silently creates an anti forgery field like form_for
* as in the example above, we are not creating or editing a record. When are simply authenticating a user - checking to see if they exist and verifying credentials.

Q: How are :email and :password parameters used in the sessions controller and view? Where are they being created?

A: Referencing email and password of users.


Q:
___
<h1>Log in</h1>

<%= form_tag sessions_path do %>
  <div class="field">
    <%= label_tag :email %><br/>
    <%= text_field_tag :email, params[:email] %>
  </div>
  <div class="field">
    <%= label_tag :password %><br/>
    <%= password_field_tag :password %>
  </div>
  <div class="actions"><%= submit_tag "Log in" %></div>
<% end %>
___
A: Using form_tag because there is no model associated with the session.
* Login Form / sessions/new.html.erb
* cannot use form_for in this case
* use form_tag
  * tell it where the form is going to post to
  * where should this form submit the information to
  * i.e sessions controller / create action.


def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to products_url notice: "Logged In!"
    else
      render :new
    end
  end

Q: At what point in this process is the session hash created? Where does it live and how is it used exactly?


<%= form_tag sessions_path do %>
* do not need the |f| in this case because we are not iterating over a list!

<%= form_tag sessions_path do %>

9. Adding flash alerts and notices

Flash
* cleared with each request
http://guides.rubyonrails.org/action_controller_overview.html#the-flash

redirect_to products_url, notice: "Logged In!"
* remember to put a comma after products_url!
