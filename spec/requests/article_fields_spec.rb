require 'rails_helper'

RSpec.describe "ArticleFields", type: :request do
  let(:article_category) { create(:article_category) }

  it "renders the fields index" do
    article_field = create(:article_field, article_category: article_category)

    get new_article_category_article_path(article_category)

    expect(response).to have_http_status(:ok)
    expect(response.body).to include(article_field.name)
  end

  it "render the new article field form" do
    get new_article_category_article_field_path(article_category)

    expect(response).to have_http_status(:ok)
    expect(response.body).to include("New #{article_category.name} field")
  end

  it "creates a new article field" do
    post article_category_article_fields_path(article_category), params: { article_field: { name: "New Field Name" } }

    expect(response.body).to include("New Field Name")
  end
end
