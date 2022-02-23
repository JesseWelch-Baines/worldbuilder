class WritableInstance < ApplicationRecord
  belongs_to :writable, polymorphic: true
  belongs_to :document

  after_destroy :reorder_document

  def reorder_document
    document.sort_instances
  end

end
