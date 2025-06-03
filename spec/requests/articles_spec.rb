require "rails_helper"

RSpec.describe "articles", type: :request do
  let(:article_category) { create(:article_category) }

  it "renders the index page" do
    get article_category_articles_path(article_category)

    expect(response).to have_http_status(:ok)
    expect(response.body).to include(article_category.name.pluralize)
  end

  it "renders the show page" do
    article = create(:article, category: article_category)
    get article_category_article_path(article_category, article)

    expect(response).to have_http_status(:ok)
    expect(response.body).to include(article.name)
  end

  it "renders the new page" do
    get new_article_category_article_path(article_category)

    expect(response).to have_http_status(:ok)
    expect(response.body).to include("New Article")
  end

  it "renders the edit page" do
    article = create(:article, category: article_category)
    get edit_article_category_article_path(article_category, article)

    expect(response).to have_http_status(:ok)
    expect(response.body).to include(article.name)
  end

  it "creates a new article" do
    post article_category_articles_path(article_category), params: { article: { name: "New Article" } }

    expect(response).to redirect_to(article_category_articles_path(article_category))
    follow_redirect!

    expect(response.body).to include("New Article")
  end

  it "updates an existing article" do
    article = create(:article, category: article_category)
    patch article_category_article_path(article_category, article), params: { article: { name: "Updated Article" } }

    expect(response).to redirect_to(article_category_articles_path(article_category))
    follow_redirect!

    expect(response.body).to include("Updated Article")
  end

  it "deletes an article" do
    article = create(:article, category: article_category)
    delete article_category_article_path(article_category, article)

    expect(response).to redirect_to(article_category_articles_path(article_category))
    follow_redirect!

    expect(response.body).to include("#{article.name} deleted")
  end
end
