$(document).ready(function () {
  $('a[href^="#"]').click(function (e) {
    $('html, body').animate({
      scrollTop: $('[name="' + $.attr(this, 'href').substr(1) + '"]').offset().top - 90
    }, 500);
    return false;
  });

  $('#newsletter').ajaxChimp({
    url: 'http://whatweate.us9.list-manage.com/subscribe/post?u=3ae9a01a53d464033afcc3009&id=eb7d06a555',
    callback: function (data) {
      ga('send', 'event', 'newsletter', 'submit', 'fill in newsletter');
      $('#response').text(data.msg);
    }
  });

  $('[data-ga]').on('click', function () {
    switch(this.getAttribute('data-ga')) {
      case 'conversion':
        ga('send', 'event', 'conversion', 'click', $(this).text().trim());
      case 'events':
        ga('send', 'event', 'conversion', 'click', this.getAttribute('title'));
      case 'social':
        ga('send', 'event', 'social', 'click', $(this).text().trim());
    }
  });
});
