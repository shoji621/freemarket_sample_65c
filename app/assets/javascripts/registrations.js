$(function() {
    var password  = '#user_password';
    var passcheck = '#user_passcheck';
	
    changeInputtype(password, passcheck);

    varidationMessage();
});

// password欄のtext化
function changeInputtype(password, passcheck) {
    $(passcheck).change(function() {
        if ($(this).prop('checked')) {
            $(password).attr('type','text');
        } else {
            $(password).attr('type','password');
        }
    });
}

// バリデーションエラーのメッセージによるビュー崩れの修正
function varidationMessage() {
    $("div:has(.half)").addClass("halffix");

    if ($('.has-error.halffix').length){
      $('.input-default.half').removeClass('half');
    }
}

