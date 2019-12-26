$(function() {
    var password  = '#user_password';
    var passcheck = '#user_passcheck';
	
    changeInputtype(password, passcheck);
});

function changeInputtype(password, passcheck) {
    $(passcheck).change(function() {
        if ($(this).prop('checked')) {
            $(password).attr('type','text');
        } else {
            $(password).attr('type','password');
        }
    });
}