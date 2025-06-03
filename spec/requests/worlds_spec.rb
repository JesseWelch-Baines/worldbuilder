require "rails_helper"

RSpec.describe "worlds", type: :request do
  it "renders the index page" do
    get worlds_path

    expect(response).to have_http_status(:ok)
    expect(response.body).to include("Worlds")
  end

  it "renders the show page" do
    world = create(:world)
    get world_path(world)

    expect(response).to have_http_status(:ok)
    expect(response.body).to include(world.name)
  end

  it "renders the new page" do
    get new_world_path

    expect(response).to have_http_status(:ok)
    expect(response.body).to include("New World")
  end

  it "renders the edit page" do
    world = create(:world)
    get edit_world_path(world)

    expect(response).to have_http_status(:ok)
    expect(response.body).to include(world.name)
  end

  it "creates a new world" do
    post worlds_path, params: { world: { name: "New World" } }

    expect(response).to redirect_to(worlds_path)
    follow_redirect!

    expect(response.body).to include("New World")
  end

  it "updates an existing world" do
    world = create(:world)
    patch world_path(world), params: { world: { name: "Updated World" } }

    expect(response).to redirect_to(worlds_path)
    follow_redirect!

    expect(response.body).to include("Updated World")
  end

  it "deletes a world" do
    world = create(:world)
    delete world_path(world)

    expect(response).to redirect_to(worlds_path)
    follow_redirect!

    expect(response.body).to include("#{world.name} deleted")
  end
end
