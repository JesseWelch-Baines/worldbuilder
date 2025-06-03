require "rails_helper"

RSpec.describe "documents", type: :request do
  it "renders the index page" do
    get documents_path

    expect(response).to have_http_status(:ok)
    expect(response.body).to include("Documents")
  end

  it "renders the show page" do
    document = create(:document)
    get document_path(document)

    expect(response).to have_http_status(:ok)
    expect(response.body).to include(document.name)
  end

  it "renders the new page" do
    get new_document_path

    expect(response).to have_http_status(:ok)
    expect(response.body).to include("New Document")
  end

  it "renders the edit page" do
    document = create(:document)
    get edit_document_path(document)

    expect(response).to have_http_status(:ok)
    expect(response.body).to include(document.name)
  end

  it "creates a new document" do
    post documents_path, params: { document: { name: "New Document" } }

    expect(response).to redirect_to(documents_path)
    follow_redirect!

    expect(response.body).to include("New Document")
  end

  it "updates an existing document" do
    document = create(:document)
    patch document_path(document), params: { document: { name: "Updated Document" } }

    expect(response).to redirect_to(documents_path)
    follow_redirect!

    expect(response.body).to include("Updated Document")
  end

  it "deletes a document" do
    document = create(:document)
    delete document_path(document)

    expect(response).to redirect_to(documents_path)
    follow_redirect!

    expect(response.body).to include("#{document.name} deleted")
  end
end
