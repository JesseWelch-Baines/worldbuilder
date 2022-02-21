class AddCustomFieldValuesToWritables < ActiveRecord::Migration[6.1]
  def change
    add_column :characters, :custom_field_values, :jsonb, default: {}
    add_column :locations, :custom_field_values, :jsonb, default: {}
    add_column :items, :custom_field_values, :jsonb, default: {}
    add_column :events, :custom_field_values, :jsonb, default: {}
  end
end
