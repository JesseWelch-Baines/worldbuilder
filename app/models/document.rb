class Document < ApplicationRecord
  belongs_to :user
  belongs_to :world
  has_many :writable_instances, -> { order(order: :asc) }, dependent: :destroy

  validates_presence_of :name

  before_validation :set_world

  def description
    return '' unless writable_instances.present?

    writable_instances.first.writable.description.to_s
  end

  def instances
    writable_instances.size
  end

  def sort_instances
    writable_instances.each_with_index do |writable_instance, index|
      writable_instance.update(order: index) unless writable_instance.order == index
    end
  end

  def sort_new_instance(instance_id, order)
    writable_instances.select { |wi| wi.order >= order.to_i }.each do |writable_instance|
      next if writable_instance.id == instance_id

      writable_instance.update(order: writable_instance.order + 1)
    end
  end

  def set_world
    self.world_id = Current.world.id if Current.world.present?
  end
end
