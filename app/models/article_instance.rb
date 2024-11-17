class ArticleInstance < ApplicationRecord
  belongs_to :article, polymorphic: true
  belongs_to :document

  after_destroy :reorder_document

  def reorder_document
    document.sort_instances
  end
end
