class ArticleCategoriesController < ApplicationController
  before_action :set_article_categories, only: [:index]
  before_action :set_article_category, only: [:show]

  def index; end

  def show; end

  def new
    @article_category = current_user.article_categories.new
  end

  def create
    @article_category = current_user.article_categories.new(article_category_params)

    respond_to do |format|
      if @article_category.save
        format.html { redirect_to article_categories_path(@article_category), notice: "#{@article_category.name} created" }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  private

  def article_category_params
    params.require(:article_category).permit(:name)
  end

  def set_article_categories
    @article_categories = current_user.article_categories
  end

  def set_article_category
    @article_category = current_user.article_categories.find(params[:id])
  end
end
