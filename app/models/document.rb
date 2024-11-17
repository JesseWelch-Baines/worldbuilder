class Document < ApplicationRecord
  belongs_to :user
  belongs_to :world
  has_many :article_instances, -> { order(order: :asc) }, dependent: :destroy, inverse_of: :document

  validates :name, presence: true

  before_validation :set_world

  def description
    return "" if article_instances.empty?

    article_instances.first.article.description.to_s
  end

  def instances
    article_instances.size
  end

  def sort_instances
    article_instances.each_with_index do |article_instance, index|
      article_instance.update(order: index) unless article_instance.order == index
    end
  end

  def sort_new_instance(instance_id, order)
    article_instances.select { |wi| wi.order >= order.to_i }.each do |article_instance|
      next if article_instance.id == instance_id

      article_instance.update(order: article_instance.order + 1)
    end
  end

  private

  def set_world
    self.world_id = Current.world.id if Current.world.present?
  end
end
