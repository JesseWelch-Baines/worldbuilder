require 'rails_helper'

RSpec.describe Document, type: :model do
  describe "validations" do
    it "has a valid factory" do
      expect(build(:document)).to be_valid
    end

    it "is not valid without a name" do
      document = build(:document, name: nil)

      expect(document).not_to be_valid
      expect(document.errors[:name]).to include("can't be blank")
    end
  end
end
