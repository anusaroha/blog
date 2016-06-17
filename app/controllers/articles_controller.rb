class ArticlesController < ApplicationController

before_action :find_article, only: [:show, :edit, :update, :destroy]
before_action :authenticate_user!, execpt: [:show, :index]
  def index
    @articles = Article.search(params[:search])
    @articles = Article.order(created_at: :desc)
  end

def edit
end

  def show
    @comment = Comment.new
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
    if @article.update article_params
      redirect_to article_path(@article), notice: "Article Updated"
    else
      render :edit
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path, notice: "Questions deleted"
  end

  private
    def article_params
      article_params = params.require(:article).permit(:title, :text, :category_id)
    end

    def find_article
      @article = Article.find params[:id]
    end

    def authenticate_user!
      redirect_to new_session_path, alert: "Please sign in" unless user_signed_in?
    end
end
