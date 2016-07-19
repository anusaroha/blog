class CommentsController < ApplicationController
  before_action :authorize_user, only: [:edit, :update, :destroy]

  def create
    @comment   = Comment.new comment_params
    @article = Article.find params[:article_id]
    @comment.article = @article
    if @comment.save
      redirect_to article_path(@article), notice: "Comment created!"
    else
      render "/article/show"
    end

    def destroy
      comment = Comment.find params[:id]
      article = Article.find params[:question_id]
      redirect_to root_path, alert: "access denined" unless can? :destroy, @comment
      comment.destroy
      redirect_to article_path(article), notice: "Comment deleted"
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:body)
    end
end
