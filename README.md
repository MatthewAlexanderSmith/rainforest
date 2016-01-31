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

10. Adding logic to display 'Signed in as' or 'Login or Sign up' in the application view

helper_methods
* used to share methods defined in the controller with a view.
* typical helper methods are not available in the views

Q: helper_method :current_user
* looks like you need to define a method as a helper_method

Q: protect_from_forgery
* how does this work exactly?
* exists by default in the application_controller

11. Creating review model and associating the user, product and review models

UML
* standard for drawing

Associations come in 6 different forms:

* belongs_to
  * specifies the direction of the relationship
  * and specifies that 'reviews' in this case, must have a foreign key.

has_one
has_many
has_many :through
has_one :through
has_and_belongs_to_many

Nested routes
* Nested routes allow you to capture an associative relationship in your routing. In this case, you could include this route declaration and remove the routes generated above:

  resources :products do
     resources :reviews, only: [:show, :create, :destroy]
   end

 READ MORE
 http://guides.rubyonrails.org/action_controller_overview.html
 * Veeery helpful


READ MORE
http://guides.rubyonrails.org/association_basics.html
Section 4 is very helpful. Includes details about how to use  association methods, and what methods are available once you define associations in the models.

 @review = @product.reviews.build(review_params)
 * creates a new instance of Review that is associated with @product which was loaded when the private method load_product was called. The value related to the :product_id key in the url was passed to the params hash.

 Q: referencing the 'collection' i.e 'reviews' plural is a little confusing here.

 @review.user = current_user
 * sets the user_id field equal to the current user id?
 * the current_user method pulls the current user from the sessions hash? and returns the id?


redirect_to products_url, notice: "Review Saved Succesfully!"
* remember the , after products_url!

render 'products/show'
Q: is there a symbol I can use instead of 'products/show'?

params.require(:review).permit(:comment, :product_id)
Q: :comment is entered through a form somewhere?
Q: :product_id is passed to the params hash from the URL?

____
def show
  @product = Product.find(params[:id])

  if current_user
    @review = @product.reviews.build
  end
end

if current_user
  @review = @product.reviews.build
end

Q:
* if current_user is true (if there is presently a user signed in)
* instantiate a new instance of Review and associat with @product, I.E the product we are looking at on the show page (/products/:id)
____

____
<% @product.reviews.each do |review|  %>
  <p>
    <%= review.comment %>
    <br>
    <% if review.user != nil  %>
      <em> by <%= review.user.email %></em>
      Added on: <%= review.created_at %>
    <% end %>
  </p>
<% end %>

Q: why <% if review.user != nil  %>? Is it possible to create a review without being logged in? Isn't every review associated with a user?
* is this code there so that only users who have accounts can see other users emails?
____

<%= form_for ([@product, @review]) do |f| %>

Q: looks like you can pass form_for an array of objects, which tells it about associations?

Q: Where @product = Product.find(params[:id]) and @review = @product.reviews.build
as defined in the products#show action.
