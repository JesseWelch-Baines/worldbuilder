class DocumentsController < ApplicationController

  before_action :writable_objects, only: [:show]

  def index
    @documents = current_user.documents.where(world_id: Current.world.id)
  end

  def edit
    @document = Document.find(params[:id])
  end

  def update
    @document = Document.find(params[:id])

    if @document.update(document_params)
      redirect_to documents_path
    else
      respond_to do |format|
        format.html { render :edit, status: :unprocessable_entity}
      end
    end
  end

  def new
    @document = Document.new
  end

  def create
    @document = current_user.documents.new(document_params)

    if @document.save
      redirect_to document_path(@document)
    else
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity}
      end
    end
  end

  def show
    @document = Document.find(params[:id])
    @writable_fields = current_user.writable_fields.where(world_id: Current.world.id)
  end

  def destroy
    @document = Document.find(params[:id]).destroy

    redirect_to documents_path
  end

  def writable_instances
    writable_instances = Document.find(params[:id]).writable_instances

    writable_instances_array = []

    writable_instances.each do |writable_instance|
      writable_instance_object = writable_instance.writable.as_json
      writable_instance_object['description'] = writable_instance.writable.description.body
      writable_instances_array << writable_instance_object
    end

    respond_to do |format|
      format.json { render json: writable_instances_array }
    end
  end

  private

  def document_params
    params.require(:document).permit(:name, :new_paragraph_body)
  end

  def writable_objects
    @paragraphs = current_user.paragraphs.includes(:rich_text_description).where(world_id: Current.world.id).select(&:active?)
    @characters = current_user.characters.includes(:rich_text_description).where(world_id: Current.world.id)
    @locations = current_user.locations.includes(:rich_text_description).where(world_id: Current.world.id)
    @items = current_user.items.includes(:rich_text_description).where(world_id: Current.world.id)
    @events = current_user.events.includes(:rich_text_description).where(world_id: Current.world.id)
  end

end
