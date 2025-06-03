require "rails_helper"

RSpec.describe "articles", type: :request do
  let(:article_category) { create(:article_category, user: @current_user) }

  it "renders the index page" do
    get article_category_articles_path(article_category)
    expect(response).to have_http_status(:ok)
    expect(response.body).to include(article_category.name.pluralize)
  end
end
