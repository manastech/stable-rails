(function($) {

  $.fn.stable = function() {
    return this.each(function() {
      var stable = $(this);

      var initialized = stable.hasClass('on');

      if (initialized) {
        // reset
        stable.removeClass('on');
        $('.scroll-vertical div', stable).height('auto');
        $('.scroll-horizontal div', stable).width('auto');
      }

      var top_left_cell = $('.c-left .t-header', stable);

      $('.scroll-vertical div', stable).height($('.c-right', stable).height());
      $('.scroll-horizontal div', stable).width($('.c-right', stable).width()+$('.c-left', stable).width());

      stable.addClass('on');

      if (!initialized) {
        var fix_table_size = function() {
          $('.c-right', stable).width(stable.width() - top_left_cell.width());
          $('.t-body', stable).height(stable.height() - top_left_cell.height());
        }
        fix_table_size();
        $(window).resize(fix_table_size);

        // Para el Scroll VERTICAL
        $('.scroll-vertical', stable).scroll(function(){
           $('.vertical', stable).scrollTop($(this).scrollTop());
        });

        // Para el Scroll HORIZONTAL
        $('.scroll-horizontal', stable).scroll(function(){
           $('.horizontal', stable).scrollLeft($(this).scrollLeft());
        });

        // Para la tabla
        $('.mask', stable).mousewheel(function(event, delta, deltaX, deltaY) {
          if (!stable.hasClass('on')) return;

          var newLeft = $('.horizontal', stable).scrollLeft() + 25 * deltaX;
          var newTop = $('.vertical', stable).scrollTop() - 25 * deltaY;

          $('.horizontal', stable).scrollLeft(newLeft);
          $('.vertical', stable).scrollTop(newTop);

          $('.scroll-horizontal', stable).scrollLeft(newLeft);
          $('.scroll-vertical', stable).scrollTop(newTop);

          event.preventDefault();
        });
      }
    });
  };

  $(function(){
    $('.stable').stable();
  });

})(jQuery);
