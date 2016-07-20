class LikesMailer < ApplicationMailer
  def notify_article_owner(like)
    @user = like.user
    @article = like.article
    mail(to: @article.user.email, subject: "#{@user.full_name} liked you post")
  end
end
