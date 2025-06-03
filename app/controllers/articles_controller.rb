class ArticlesController < ApplicationController
  before_action :set_article_category
  before_action :set_articles, only: [:index]
  before_action :set_article, only: [:show]

  def index; end

  def show; end

  def new
    @article = current_user.articles.new
  end

  def create
    @article = current_user.articles.new(article_params.merge(category: @article_category))

    respond_to do |format|
      if @article.save
        format.html { redirect_to article_category_articles_path(@article_category), notice: "#{@article.name} created" }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  private

  def article_params
    params.require(:article).permit(:name)
  end

  def set_article_category
    @article_category = current_user.article_categories.find(params[:article_category_id])
  end

  def set_articles
    @articles = current_user.articles.where(article_category_id: @article_category.id)
  end

  def set_article
    @article = current_user.articles.find(params[:id])
  end
end
