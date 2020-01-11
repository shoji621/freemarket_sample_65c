$(function(){
  $('.imgs-sub').hover(function(){
      //オーバーした画像urlを取得
      var imageurl = $(this).attr('src');
      $('.imgs-main').attr('src',imageurl);
  });
});