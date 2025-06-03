class Article < ApplicationRecord
  include ActionText::Attachable

  belongs_to :world
  belongs_to :category, class_name: "ArticleCategory", foreign_key: "article_category_id", inverse_of: :articles
  has_many :article_instances, dependent: :restrict_with_error, inverse_of: :article
  has_rich_text :description

  before_validation :set_world
  before_destroy :destroy_instances

  attr_accessor :document_id

  def occurrences
    article_instances.size
  end

  def create_instance(user_id, document_id, order)
    instance_id = article_instances.create(user_id: user_id, document_id: document_id, order: order).id
    Document.find(document_id).sort_new_instance(instance_id, order)
  end

  def article_fields(user_id, world_id)
    ArticleField.where(user_id: user_id, world_id: world_id, model: self.class.to_s).order(:order)
  end

  def set_world
    return if world_id.present?

    self.world_id = Current.world.id if Current.world.present?
  end

  def destroy_instances
    article_instances.each(&:destroy)
  end
end
