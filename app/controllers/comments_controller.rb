class CommentsController < ApplicationController
  def create
    @comment = Comment.create(comment_params)
    if @comment.save
      respond_to do |format|
        format.html { redirect_to item_path(params[:item_id])  }
        format.json
      end
    else
      flash.now[:alert] = 'コメントを入力してください。'
      redirect_to item_path(params[:item_id])
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end
