require 'rails_helper'

RSpec.describe World, type: :model do
  describe "validations" do
    it "has a valid factory" do
      expect(build(:world)).to be_valid
    end

    it "is not valid without a name" do
      world = build(:world, name: nil)

      expect(world).not_to be_valid
      expect(world.errors[:name]).to include("can't be blank")
    end
  end
end
