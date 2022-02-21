class LocationsController < WritablesController

  def index
    @locations = current_user.locations.where(world_id: Current.world.id)
  end

  def new
    @location = Location.new
  end

  def create
    @location = current_user.locations.new(location_params)

    if @location.save
      update_writable_fields('Location', params[:location][:custom_fields])
      respond_to do |format|
        format.html {redirect_to locations_path, notice: "Location created"}
      end
    else
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity}
      end
    end
  end

  def create_from_document
    @document = Document.find(params[:document_id])

    location = current_user.locations.create(name: params["new_location_#{params[:order]}"][:name], description: params["new_location_#{params[:order]}"][:description], custom_field_values: params[:location][:custom_field_values], world_id: Current.world.id)
    location.create_instance(current_user.id, @document.id, params[:order])

    redirect_to document_path(@document)
  end

  def edit
    @location = Location.find(params[:id])
  end

  def update
    @location = Location.find(params[:id])

    if @location.update(location_params)
      update_writable_fields('Location', params[:location][:custom_fields])
      if location_params[:document_id].present?
        redirect_to document_path(location_params[:document_id])
      else
        respond_to do |format|
          format.html {redirect_to edit_location_path(@location), notice: "Location updated"}
        end
      end
    else
      respond_to do |format|
        format.html { render :edit, status: :unprocessable_entity}
      end
    end
  end

  def show
    @location = Location.includes(writable_instances: :document).find(params[:id])
    @writable_fields = WritableField.where(user_id: current_user, world_id: Current.world, model: 'Location').order(:order)
  end

  def destroy
    @location = Location.find(params[:id])

    @location.destroy

    redirect_to locations_path
  end

  def fetch
    locations = current_user.locations.select(:id, :name).where(world_id: Current.world.id).order(:updated_at)

    respond_to do |format|
      format.json { render json: locations }
    end
  end

  def create_instance
    Location.find(params[:id]).create_instance(current_user.id, params[:document_id], params[:order])

    redirect_to document_path(params[:document_id])
  end

  private

  def location_params
    params.require(:location).permit(:name, :description, :document_id, custom_field_values: {})
  end
end
