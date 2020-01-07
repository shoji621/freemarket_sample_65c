$(function() {
  $('.exhibition-form__price-info__box__price__right__form').on('keyup', function(){
    var input = $(this).val();
    var fee = Math.floor(input * 0.1);
    var gain = input - fee ;
    $('.exhibition-form__price-info__box__postage__price').html("¥" + fee);
    $('.exhibition-form__price-info__box__profit__price').html("¥" + gain);
  });
});