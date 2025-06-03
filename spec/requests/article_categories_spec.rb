require "rails_helper"

RSpec.describe "article_categories", type: :request do
  it "renders the index page" do
    get article_categories_path
    expect(response).to have_http_status(:ok)
    expect(response.body).to include("Article Categories")
  end
end
