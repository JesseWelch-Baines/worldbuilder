class EventsController < WritablesController

  def index
    @events = current_user.events.where(world_id: Current.world.id)
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.new(event_params)

    if @event.save
      update_writable_fields('Event', params[:event][:custom_fields])
      respond_to do |format|
        format.html {redirect_to events_path, notice: "Event created"}
      end
    else
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity}
      end
    end
  end

  def create_from_document
    @document = Document.find(params[:document_id])

    event = current_user.events.create(name: params["new_event_#{params[:order]}"][:name], description: params["new_event_#{params[:order]}"][:description], custom_field_values: params[:event][:custom_field_values], world_id: Current.world.id)
    event.create_instance(current_user.id, @document.id, params[:order])

    redirect_to document_path(@document)
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])

    if @event.update(event_params)
      update_writable_fields('Event', params[:event][:custom_fields])
      if event_params[:document_id].present?
        redirect_to document_path(event_params[:document_id])
      else
        respond_to do |format|
          format.html {redirect_to edit_event_path(@event), notice: "Event updated"}
        end
      end
    else
      respond_to do |format|
        format.html { render :edit, status: :unprocessable_entity}
      end
    end
  end

  def show
    @event = Event.includes(writable_instances: :document).find(params[:id])
    @writable_fields = WritableField.where(user_id: current_user, world_id: Current.world, model: 'Event').order(:order)
  end

  def destroy
    @event = Event.find(params[:id])

    @event.destroy

    redirect_to events_path
  end
  
  def fetch
    events = current_user.events.select(:id, :name).where(world_id: Current.world.id).order(:updated_at)

    respond_to do |format|
      format.json { render json: events }
    end
  end
  
  def create_instance
    Event.find(params[:id]).create_instance(current_user.id, params[:document_id], params[:order])

    redirect_to document_path(params[:document_id])
  end

  private
  
  def event_params
    params.require(:event).permit(:name, :description, :document_id, custom_field_values: {})
  end
end
