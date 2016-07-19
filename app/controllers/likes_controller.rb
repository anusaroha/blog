class LikesController < ApplicationController
  before_action :authenticate_user

  def create
    like = current_user.likes.new
    article = Article.find params[:article_id]
    like.article = article
    if like.save
      LikesMailer.notify_article_owner(like).deliver_now
      redirect_to article, notice: "Liked!"
    else
      redirect_to article, notice: "Didn't Like!"
    end
  end

  def destroy
    article = Article.find params[:article_id]
    like = current_user.likes.find params[:id]
    like.destroy
    redirect_to like.article, notice: "Unliked"
  end
end
