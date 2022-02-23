class WritableField < ApplicationRecord

  before_destroy :collect_custom_field_values

  def collect_custom_field_values
    writables = Object.const_get(model).where(world_id: Current.world.id)

    writables.each do |writable|
      writable.custom_field_values = writable.custom_field_values.except(id.to_s)
      writable.save
    end
  end

  def index_links
    {
      move_up_path: move_up_writable_field_path(self, callback: fields_index_characters_path),
      move_down_path: move_down_writable_field_path(self, callback: fields_index_characters_path)
    }
  end

end
