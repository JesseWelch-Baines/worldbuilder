require "rails_helper"

RSpec.describe "article_categories", type: :request do
  it "renders the index page" do
    get article_categories_path

    expect(response).to have_http_status(:ok)
    expect(response.body).to include("Article Categories")
  end

  it "renders the show page" do
    article_category = create(:article_category)
    get article_category_path(article_category)

    expect(response).to have_http_status(:ok)
    expect(response.body).to include(article_category.name)
  end

  it "renders the new page" do
    get new_article_category_path

    expect(response).to have_http_status(:ok)
    expect(response.body).to include("New Article category")
  end

  it "renders the edit page" do
    article_category = create(:article_category)
    get edit_article_category_path(article_category)

    expect(response).to have_http_status(:ok)
    expect(response.body).to include(article_category.name)
  end

  it "creates a new article category" do
    post article_categories_path, params: { article_category: { name: "New Category" } }

    expect(response).to redirect_to(article_category_articles_path(article_category_id: ArticleCategory.order(:created_at).last.id))
    follow_redirect!

    expect(response.body).to include("New Category")
  end

  it "updates an existing article category" do
    article_category = create(:article_category)
    patch article_category_path(article_category), params: { article_category: { name: "Updated Category" } }

    expect(response).to redirect_to(article_categories_path)
    follow_redirect!

    expect(response.body).to include("Updated Category")
  end

  it "deletes an article category" do
    article_category = create(:article_category)
    delete article_category_path(article_category)

    expect(response).to redirect_to(article_categories_path)
    follow_redirect!

    expect(response.body).to include("#{article_category.name} deleted")
  end
end
