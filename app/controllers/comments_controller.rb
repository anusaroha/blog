class CommentsController < ApplicationController
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
      comment.destroy
      redirect_to article_path(article), notice: "Comment deleted"
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:body)
    end
end
