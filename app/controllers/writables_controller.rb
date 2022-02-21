class WritablesController < ApplicationController

  def update_writable_fields(model, new_fields)
    return if new_fields.blank?

    existing_fields = current_user.writable_fields.where(world_id: Current.world.id, model: model)

    new_fields.each do |id, details|
      next if details[:name].blank?

      if existing_fields.pluck(:id).include?(id)
        existing_fields.find(id).update(name: details[:name])
      else
        details[:order] = existing_fields.size if details[:order] == '-1'
        current_user.writable_fields.create(id: id, world_id: Current.world.id, model: model, name: details[:name], order: details[:order])
        Current.world.insert_writable_field(model, id, details[:order])
      end

    end

  end

  def fields_index
    @model = controller_name.classify
    @fields = current_user.writable_fields.where(world_id: Current.world.id, model: @model).order(:order)
  end

  def export_list
    pdf = Current.world.generate_writable_list(params[:model])
    send_data(pdf, filename: "#{params[:model].capitalize} (#{Current.world.name}).pdf", type: "application/pdf")
  end

end
