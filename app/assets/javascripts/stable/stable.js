(function($) {

  $.fn.stable = function() {
    var stable = $(this);
    var top_left_cell = $('.c-left .t-header', stable);

    $('#scroll-vertical div', stable).height($('.c-right', stable).height());
    $('#scroll-horizontal div', stable).width($('.c-right', stable).width()+$('.c-left', stable).width());

    stable.css('padding-bottom', top_left_cell.outerHeight());
    stable.css('padding-right', top_left_cell.outerWidth());

    stable.addClass('on');

    // Para el Scroll VERTICAL
    $('#scroll-vertical', stable).scroll(function(){
       $('.vertical', stable).scrollTop($(this).scrollTop());
    });

    // Para el Scroll HORIZONTAL
    $('#scroll-horizontal', stable).scroll(function(){
       $('.horizontal', stable).scrollLeft($(this).scrollLeft());
    });

    // Para la tabla
    $('#mask', stable).mousewheel(function(event, delta, deltaX, deltaY) {
      if (!stable.hasClass('on')) return;

      var newLeft = $('.horizontal', stable).scrollLeft() + 25 * deltaX;
      var newTop = $('.vertical', stable).scrollTop() - 25 * deltaY;

      $('.horizontal', stable).scrollLeft(newLeft);
      $('.vertical', stable).scrollTop(newTop);

      $('#scroll-horizontal', stable).scrollLeft(newLeft);
      $('#scroll-vertical', stable).scrollTop(newTop);

      event.preventDefault();
    });
  };

  $(function(){
    $('.stable').stable();
  });

})(jQuery);
