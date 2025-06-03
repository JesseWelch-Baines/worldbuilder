require "rails_helper"

RSpec.describe "documents", type: :request do
  it "renders the index page" do
    get documents_path
    expect(response).to have_http_status(:ok)
    expect(response.body).to include("Documents")
  end
end
