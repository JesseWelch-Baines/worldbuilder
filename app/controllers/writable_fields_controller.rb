class WritableFieldsController < ApplicationController

  before_action :set_writable_field, except: [:new, :create]

  def new
    @writable_field = WritableField.new(model: params[:model])
  end

  def create
    @writable_field = current_user.writable_fields.new(writable_field_params.merge(world_id: Current.world.id))

    @writable_field.order = current_user.writable_fields.where(world_id: Current.world.id, model: writable_field_params[:model]).count

    if @writable_field.save
      respond_to do |format|
        format.html {redirect_to "/#{writable_field_params[:model].downcase.pluralize}/fields_index", notice: 'Field created' }
      end
    else
      render :new
    end
  end

  def edit
    @writable_field = WritableField.find(params[:id])
  end

  def update
    @writable_field = WritableField.find(params[:id])

    if @writable_field.update(writable_field_params)
      redirect_to "/#{@writable_field.model.downcase.pluralize}/fields_index"
    else
      render :edit
    end
  end

  def show
    @writable_field = WritableField.find(params[:id])
  end

  def move_up
    Current.world.move_writable_field(@writable_field, -1)

    redirect_to "/#{@writable_field.model.downcase.pluralize}/fields_index"
  end

  def move_down
    Current.world.move_writable_field(@writable_field, 1)

    redirect_to "/#{@writable_field.model.downcase.pluralize}/fields_index"
  end

  def destroy
    @writable_field.destroy

    redirect_to params[:callback]
  end

  private

  def writable_field_params
    params.require(:writable_field).permit(:model, :name)
  end

  def set_writable_field
    @writable_field = WritableField.find(params[:id])
  end

end