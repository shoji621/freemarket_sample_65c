$(function(){

  function buildHTML(comment) {
    let seller = (comment.user_name == comment.seller_name) ? `<div class="comment__user__seller">出品者</div>` : " " ;
    let html =
    `<li class="comment">
      <a class="comment__user" href="#">
        <i class="fas fa-user-circle comment__user__icon"></i>
        <div class="comment__user__nickname">
          ${comment.user_name}
        </div>
        ${seller}
      </a>
      <div class="comment__body">
        <div class="comment__body__text">
          ${comment.text}
        </div>
        <div class="comment__body__time">
          <i class="far fa-clock comment__body__time__icon"></i>
          ${comment.date}
        </div>
      </div>
    </li>`
    return html;
  }

  $('#new_comment').on('submit', function(e){
    e.preventDefault();
    let formData = new FormData(this);
    let url = $(this).attr('action');

    $.ajax({  
      url: url,
      type: 'POST',
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(data){
      let html = buildHTML(data);
      $('.comments').append(html);
      $('.comment__form__input').val('');
    })
    .fail(function(){
      alert('エラーが発生したためコメントは送信できませんでした。');
    })
    .always(function() {
      $('.comment__btn').prop('disabled', false);
    });
  })
});
