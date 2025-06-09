require "rails_helper"

RSpec.describe Article, type: :model do
  describe "validations" do
    it "has a valid factory" do
      expect(build(:article)).to be_valid
    end

    it "is not valid without a name" do
      article = build(:article, name: nil)

      expect(article).not_to be_valid
      expect(article.errors[:name]).to include("can't be blank")
    end
  end
end
