class Articles::ArticleFieldsController < ApplicationController
  before_action :set_article_category, only: [:new, :create]
  before_action :set_article, only: [:new, :create]

  def new
    @article_field = @article_category.article_fields.new

    render turbo_stream: turbo_stream.replace(
      "modal",
      partial: "article_fields/new",
      locals: { article_category: @article_category, article: @article, article_field: @article_field }
    )
  end

  def create
    @article_field = current_user.article_fields.new(article_field_params.merge(article_category: @article_category))

    if @article_field.save
      @article.article_field_values.new(user: @article.user, world: @article.world, article_field: @article_field)

      render turbo_stream: turbo_stream.replace(
        "article_fields",
        partial: "article_fields/index",
        locals: { article: @article, article_fields: @article_category.article_fields }
      )
    else
      render turbo_stream: turbo_stream.replace(
        "modal",
        partial: "article_fields/new",
        locals: { article_category: @article_category, article: @article, article_field: @article_field }
      )
    end
  end

  private

  def article_field_params
    params.require(:article_field).permit(:name)
  end

  def set_article_category
    @article_category = current_user.article_categories.find(params[:article_category_id])
  end

  def set_article
    @article = @article_category.articles.find(params[:article_id])
  end
end
