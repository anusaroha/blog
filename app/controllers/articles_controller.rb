class ArticlesController < ApplicationController

before_action :find_article, only: [:show, :edit, :update, :destroy]

  def index
    @articles = Article.order(created_at: :desc)
  end

  def edit
  end

  def show
    @article = Article.find(params[:id])
  end

  def new

  end

  def create
    @article = Article.new(article_params)
    @article.save
    redirect_to @article
  end

  def update
    if @article.update article_params
      redirect_to article_path(@article), notice: "Article Updated"
    end
  end

  def destroy
    @article.destroy
    redirect_to article_path, notice: "Question Deleted"
  end

  private
    def article_params
      params.require(:article).permit(:title, :text)
    end

    def find_article
      @article = Article.find params[:id]
    end
end
