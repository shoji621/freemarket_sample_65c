$(function() {
  $('.slider').slick({
    autoplay: true,
    autoplaySpeed: 5000,
    prevArrow: '<i class="fas fa-chevron-left prev-arrow"></i>',
    nextArrow: '<i class="fas fa-chevron-right next-arrow"></i>',
    dots: true,
  });
});

$(function(){
  $('a[href^="#"]').click(function(){
    var speed = 500;
    var href= $(this).attr("href");
    var target = $(href == "#" || href == "" ? 'html' : href);
    var position = target.offset().top;
    $("html, body").animate({scrollTop:position}, speed, "swing");
    return false;
  });
});