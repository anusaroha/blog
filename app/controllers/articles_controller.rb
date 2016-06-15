class ArticlesController < ApplicationController

before_action :find_article, only: [:show, :edit, :update, :destroy]

  def index
    # @articles = Article.all
    # if params[:search]
    #   @articles = Article.search(params[:search]).order("created_at DESC")
    # else
    #   @articles = Article.all.order('created_at DESC')
    # end
    #
    # @articles = Article.paginate(:page => params[:page], :per_page => 5)
    @articles = Article.search(params[:search])
    if @articles.class == Array
      @articles = Kaminari.paginate_array(@articles).page(params[:page]).per(7)
    else
      @articles = @articles.page(params[:page]).limit(7)
    end
  end

def edit
  @article = Article.find(params[:id])
end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to articles_path
  end

  private
    def article_params
      params.require(:article).permit(:title, :text)
    end

    def find_article
      @article = Article.find params[:id]
    end
end
