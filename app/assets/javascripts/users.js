$(function() {

	$('.mypage-tabs li:nth-child(1)').addClass('active');
    
	$('.mypage-tabs li').click(function() {

		var index = $(this).parent().children('li').index(this);

		$(this).parent('.mypage-tabs').each(function(){

			$('>li',this).removeClass('active').eq(index).addClass('active');

		});

		$(this).parent().next().children('.tab-content ul').hide().eq(index).show();

	}).first().click();
});