class ArticlesController < ApplicationController

before_action :authorize_user, only: [:edit, :update, :destroy]
before_action :authenticate_user!, except: [:index, :show]
before_action :find_article, only: [:show, :edit, :update, :destroy]


  def index
    @articles = Article.all
    @a = Article.ransack(params[:q])
    @people = @a.result(distinct: true)
    @articles = Article.order(:title).page params[:page]
  end

def edit
  redirect_to root_path, alert: "access defined" unless can? :edit, @article
end

  def show
    @comment = Comment.new
    @like = @article.like_for(current_user)
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new article_params
    @article.user = current_user
    if @article.save
      flash[:notice] = "Article Created!"
      redirect_to article_path(@article)
    else
      flash[:alert] = "Article not created!"
      render :new
    end
  end

  def update
    redirect_to root_path, alert: "access denined" unless can? :update, @article
    if @article.update article_params
      redirect_to article_path(@article), notice: "Article Updated"
    else
      render :edit
    end

  end

  def destroy
    redirect_to root_path, alert: "access denined" unless can? :destroy, @article
    @article.destroy
    redirect_to articles_path, notice: "Questions deleted"
  end

  private
    def article_params
      params.require(:article).permit(:title, :text, :category_id, :user_id, :tag_names)
    end

    def find_article
      @article = Article.find params[:id]
    end
end
