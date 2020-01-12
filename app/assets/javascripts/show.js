$(function(){
  $('.imgs-sub').hover(function(){
      //オーバーした画像urlを取得
      var imageurl = $(this).attr('src');
      $('.imgs-main').attr('src',imageurl);
  });


  if (!$(".nav-item").hasClass("prev")) {
    //item_id: [1]のとき右端寄せの処理
    $('.next').css('margin','0 0 0 auto');
  }
  
});