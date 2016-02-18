$(document).on('ready page:load', function() {
  $('#search-form').submit(function(event) {
    event.preventDefault();
    var searchValue = $('#search').val();

    // $.ajax({
    //   url: '/products?search=' + searchValue,
    //   type: 'GET',
    //   dataType: 'html'
    // }).done(function(data){
    //   $('#products').html(data);
    // });

    // Short Hand for the $.ajax(){}; shown above.
    // $.get('/products?search=' + searchValue)
    //  .done(function(data){
    //    console.log(data);
    //    $('#products').html(data);
    //  });

    // Another alternative to the two options above.
    $.getScript('/products?search=' + searchValue);


  });

  // $(window).scroll(function() {
  //   var url = $('.pagination span.next').children().attr('href');
  //    if ($(window).scrollTop() > $(document).height() - $(window).height() - 100) {
  //      $('.pagination').text("Fetching more products...");
  //      return $.getScript(url);
  //    }
  //  });

 });
