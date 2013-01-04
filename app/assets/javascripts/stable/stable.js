$(function(){
  // Para el Scroll VERTICAL
  $('#scroll-vertical').scroll(function(){
     $('.vertical').scrollTop($(this).scrollTop());
  });

  // Para el Scroll HORIZONTAL
  $('#scroll-horizontal').scroll(function(){
     $('.horizontal').scrollLeft($(this).scrollLeft());
  });

  // Para la tabla
  $('#mask').mousewheel(function(event, delta, deltaX, deltaY) {
    if ($('.table-scroll.on').length == 0) return;

    var newLeft = $('.horizontal').scrollLeft() + 25 * deltaX;
    var newTop = $('.vertical').scrollTop() - 25 * deltaY;

    $('.horizontal').scrollLeft(newLeft);
    $('.vertical').scrollTop(newTop);

    $('#scroll-horizontal').scrollLeft(newLeft);
    $('#scroll-vertical').scrollTop(newTop);

    event.preventDefault();
  });
});
