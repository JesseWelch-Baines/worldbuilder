class ItemsController < WritablesController

  def index
    @items = current_user.items.where(world_id: Current.world.id)
  end

  def new
    @item = Item.new
  end

  def create
    @item = current_user.items.new(item_params)

    if @item.save
      update_writable_fields('Item', params[:item][:custom_fields])
      respond_to do |format|
        format.html {redirect_to items_path, notice: "Item created"}
      end
    else
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity}
      end
    end
  end

  def create_from_document
    @document = Document.find(params[:document_id])

    item = current_user.items.create(name: params["new_item_#{params[:order]}"][:name], description: params["new_item_#{params[:order]}"][:description], custom_field_values: params[:item][:custom_field_values], world_id: Current.world.id)
    item.create_instance(current_user.id, @document.id, params[:order])

    redirect_to document_path(@document)
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])

    if @item.update(item_params)
      update_writable_fields('Item', params[:item][:custom_fields])
      if item_params[:document_id].present?
        redirect_to document_path(item_params[:document_id])
      else
        respond_to do |format|
          format.html {redirect_to edit_item_path(@item), notice: "Item updated"}
        end
      end
    else
      respond_to do |format|
        format.html { render :edit, status: :unprocessable_entity}
      end
    end
  end

  def show
    @item = Item.includes(writable_instances: :document).find(params[:id])
    @writable_fields = WritableField.where(user_id: current_user, world_id: Current.world, model: 'Item').order(:order)
  end

  def destroy
    @item = Item.find(params[:id])

    @item.destroy

    redirect_to items_path
  end

  def fetch
    items = current_user.items.select(:id, :name).where(world_id: Current.world.id).order(:updated_at)

    respond_to do |format|
      format.json { render json: items }
    end
  end

  def create_instance
    Item.find(params[:id]).create_instance(current_user.id, params[:document_id], params[:order])

    redirect_to document_path(params[:document_id])
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :document_id, custom_field_values: {})
  end
end
