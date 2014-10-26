$(document).ready(function () {
  $('a[href^="#"]').click(function (e) {
    $('html, body').animate({
      scrollTop: $('[name="' + $.attr(this, 'href').substr(1) + '"]').offset().top - 90
    }, 500);
    return false;
  });
});
