class ArticleCategoriesController < ApplicationController
  before_action :set_article_categories, only: [:index]
  before_action :set_article_category, only: [:show, :edit, :update, :destroy]

  def index; end

  def show; end

  def new
    @article_category = current_user.article_categories.new
  end

  def edit; end

  def create
    @article_category = current_user.article_categories.new(article_category_params)

    respond_to do |format|
      if @article_category.save
        format.html { redirect_to article_categories_path, notice: "#{@article_category.name} created" }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @article_category.update(article_category_params)
        format.html { redirect_to article_categories_path, notice: "#{@article_category.name} updated" }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @article_category.destroy

    respond_to do |format|
      format.html { redirect_to article_categories_path, notice: "#{@article_category.name} deleted" }
      format.json { head :no_content }
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
