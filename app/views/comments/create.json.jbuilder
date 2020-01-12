json.text  @comment.text
json.user_name  @comment.user.nickname
json.seller_name  @comment.item.seller.nickname
json.date @comment.created_at.strftime("%Y/%m/%d(%a) %H:%M")