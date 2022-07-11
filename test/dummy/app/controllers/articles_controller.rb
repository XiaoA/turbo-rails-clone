class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  def index
    @article = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(articles_params)

    if @article.save
      redirect_to articles_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @article.update(article_params)
      redirect_to articles_path
    else
      render :edit      
    end
  end

  def destroy
    @article.destroy

    redirect_to articles_path
  end

  private

  def article_params
    params.require(:article).permit(:content)
  end

  def set_article
    @article = Article.find(params[:id])
  end
end
