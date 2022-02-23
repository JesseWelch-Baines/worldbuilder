class Writable < ApplicationRecord
  self.abstract_class = true
  include ActionText::Attachable

  has_many :writable_instances

  before_destroy :destroy_instances
  before_validation :set_world

  attr_accessor :document_id

  def occurrences
    writable_instances.size
  end

  def create_instance(user_id, document_id, order)
    instance_id = writable_instances.create(user_id: user_id, document_id: document_id, order: order).id
    Document.find(document_id).sort_new_instance(instance_id, order)
  end

  def writable_fields(user_id, world_id)
    WritableField.where(user_id: user_id, world_id: world_id, model: self.class.to_s).order(:order)
  end

  def destroy_instances
    writable_instances.each(&:destroy)
  end

  def set_world
    return if self.world_id.present?

    self.world_id = Current.world.id if Current.world.present?
  end

end