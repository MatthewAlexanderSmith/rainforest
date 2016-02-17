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

___
Nested Resources
* It's common to have resources that are logically children of other resources.
* In the rain forest app for example reviews is a logical child of products.

resources :products do
  resources :reviews, only: [:show, :create, :destroy]
end
___

Filters
*
Nested Forms
Practice Refactoring views

See w4d1.md notes for more on
* filters
* callbacks
* validations
* partials

Q: Looks like the section 13 code is redundant.


Q:
___
```
<% if @product.reviews.any? %>

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

<% else %>
    <p>
      Be the first to review this product!
    </p>

<% end %>

<% if @product.reviews.any? %>
```
* returns true?


A: A new instance of Review was created and was being associated with the current product in the products controller
___

redirect_to :back
* use this to return to the page where the request was created

be rake db:drop db:create db:migrate
* kills database entirely
* makes new blank database
* runs the migrations on the new database
!!!!Never do this in production. Everything will be lost!!!!

___
```
<%= radio_button_tag "product[category_id]", category.id, @product.category_id== category.id %><%= category.name %>
```
Q: Examine.
___

Q: Add Search form to search by category
http://www.jorgecoca.com/buils-search-form-ruby-rails/

Q:
A belongs_to association represents a one to one relationship.
___

# Implementing AJAX Search

```
<%= form_tag products_path, method: :get, authentication: false, id: 'search-form' do %>
  <%= text_field_tag :search, params[:search] %>
  <%= submit_tag "Search" %>
<% end %>
```

Q: How does the form_tag line work exactly?

Q: Why 'authentication: false'?
___
```
class ProductsController < ApplicationController
  ...
  def index
    @products = if params[:search]
      Product.where("LOWER(name) LIKE LOWER(?)", "%#{params[:search]}%")
    else
      Product.all
    end
  end
  ...
end
```
Q: Why the question mark?

A: Passing values to the data base query in this format I.E an array is a way of santizing user input and avoiding SQL injection attacks. The value inside the quotations at array[1] replaces the question mark.

## LOWER(character_expression):
character_expression:
Is an expression of character or binary data. character_expression can be a constant, variable, or column. character_expression must be of a data type that is implicitly convertible to varchar. Otherwise, use CAST to explicitly convert character_expression.
* Returns a character expression after converting uppercase character data to lowercase.

https://msdn.microsoft.com/en-us/library/ms174400.aspx?f=255&MSPPError=-2147217396

## LIKE vs ILIKE

### LIKE
Determines whether a specific character string matches a specified pattern. A pattern can include regular characters and wildcard characters. During pattern matching, regular characters must exactly match the characters specified in the character string. However, wildcard characters can be matched with arbitrary fragments of the character string. Using wildcard characters makes the LIKE operator more flexible than using the = and != string comparison operators. If any one of the arguments is not of character string data type, the SQL Server Database Engine converts it to character string data type, if it is possible.
https://msdn.microsoft.com/en-us/library/ms179859.aspx

### ILIKE
The key word ILIKE can be used instead of LIKE to make the match case-insensitive according to the active locale. This is not in the SQL standard but is a PostgreSQL extension.

## %
Any string of zero or more characters.

WHERE title LIKE '%computer%' finds all book titles with the word 'computer' anywhere in the book title.
___

# Using the XHR object

```

<!-- index.html.erb -->
<tbody id="products">
  <%= render @products %>
</tbody>

<!-- bottom of page -->
<script type="text/javascript">
  function display_search_results() {
    // readyState === 4 means that the asynchronous request completed successfully
    if (this.readyState === 4) {
      console.log(this);
      document.getElementById('products').innerHTML = this.responseText;
    }
  }

  var form = document.getElementById('search-form');
  form.addEventListener('submit', function(event) {
    event.preventDefault();
    var searchValue = document.getElementById('search').value;

    var xhr = new XMLHttpRequest();
    xhr.onload = display_search_results;
    xhr.open('GET', '/products?search=' + searchValue, true);
    xhr.setRequestHeader("X-Requested-With", "XMLHttpRequest");
    xhr.send();
  });
</script>

<!-- products_controller.rb -->

def index
   @products = if params[:search]
     Product.where("LOWER(name) LIKE LOWER(?)", "%#{params[:search]}%")
   else
     Product.all
   end

   if request.xhr?
     render @products
   end
 end
 ```
 In the example above, this line of code:

```
document.getElementById('products').innerHTML = this.responseText;
```

injects the responseText included in the GET request into the DOM element with id="products"?

I did this:
```
<tbody id="products">
  <%= render @products %>
</tbody>
```
and it worked...

Q: Rails magic? Let's elaborate on this a bit.
___

#jQuery $.aJax

#### Why page:load?
```
$(document).on('ready page:load', function() {
  // put your javascript here
});
```
Q: Why add page:load here? Doesn't just 'ready' alone ensure the entire document is load before executing the callback function?

## val()

```
var searchValue = $('#search').val();
```
Get the current value of the first element in the set of matched elements or set the value of every matched element.

The .val() method is primarily used to get the values of form elements such as input, select and textarea. In the case of select elements, it returns null when no option is selected and an array containing the value of each selected option when there is at least one and it is possible to select more because the multiple attribute is present.

## $.ajax

### Perform an asynchronous HTTP (Ajax) request.

```
$(document).on('ready page:load', function() {
  $('#search-form').submit(function(event) {
    event.preventDefault();
    var searchValue = $('#search').val();

    $.ajax({
      url: '/products?search=' + searchValue,
      type: 'GET',
      dataType: 'html'
    }).done(function(data){
      $('#products').html(data);
    });
  });
});
```

Q: In a get request, the information from the form I.E the query string is placed in the url:

```
url: '/products?search=' + searchValue,
```
Q: The question mark separates the path from the query. You can obviously append a variable onto the end of a query as shown above.

## .get() shorthand
#### .ajax() has multiple shorthands

```
$.get('/products?search=' + searchValue)
 .done(function(data){
   console.log(data);
   $('#products').html(data);
 });
 ```

 Q: in the code above, where is 'data' coming from? Is it an object that is by default, passed back with the request?


## $.getScript()
#### another shorthand function
Expects a script as a response - doesn't have the data type option. Once it receives a script it will execute the script.

Prevents the need for a callback - the script acts like a callback.

```
$('#products').html("<%= escape_javascript(render @products) %>");
```

Inside the template, we add javascript and erb. The erb portion gets interpreted first, therefore allowing you to generate responses that are partially html or strings. escape_javascript takes care of ensuring there are no issues with formatting by the time it gets executed as JS. escape_javascript can also be represented as j.

Q: pertains the the note above. Is erb executed on the server side and compiled to html / js before the response is sent back? And, how does escape_javascript actually work?

Does it essentially remove special characters that will screw up the javascript? Can we elaborate pls?
