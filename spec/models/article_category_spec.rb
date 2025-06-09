require 'rails_helper'

RSpec.describe ArticleCategory, type: :model do
  describe "validations" do
    it "has a valid factory" do
      expect(build(:article_category)).to be_valid
    end

    it "is not valid without a name" do
      article_category = build(:article_category, name: nil)

      expect(article_category).not_to be_valid
      expect(article_category.errors[:name]).to include("can't be blank")
    end
  end
end
