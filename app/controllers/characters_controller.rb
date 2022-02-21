class CharactersController < WritablesController

  def index
    @characters = current_user.characters.where(world_id: Current.world.id)
  end

  def new
    @character = Character.new
  end

  def create
    @character = current_user.characters.new(character_params)

    if @character.save
      update_writable_fields('Character', params[:character][:custom_fields])
      respond_to do |format|
        format.html {redirect_to characters_path, notice: "Character created" }
      end
    else
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity}
      end
    end
  end

  def create_from_document
    @document = Document.find(params[:document_id])

    character = current_user.characters.create(name: params["new_character_#{params[:order]}"][:name], description: params["new_character_#{params[:order]}"][:description], custom_field_values: params[:character][:custom_field_values], world_id: Current.world.id)
    character.create_instance(current_user.id, @document.id, params[:order])

    redirect_to document_path(@document)
  end

  def edit
    @character = Character.find(params[:id])
  end

  def update
    @character = Character.find(params[:id])

    if @character.update(character_params)
      update_writable_fields('Character', params[:character][:custom_fields])
      if character_params[:document_id].present?
        redirect_to document_path(character_params[:document_id])
      else
        respond_to do |format|
          format.html {redirect_to edit_character_path(@character), notice: "Character updated"}
        end
      end
    else
      respond_to do |format|
        format.html { render :edit, status: :unprocessable_entity}
      end
    end
  end

  def show
    @character = Character.includes(writable_instances: :document).find(params[:id])

    @writable_fields = WritableField.where(user_id: current_user, world_id: Current.world, model: 'Character').order(:order)
  end

  def destroy
    @character = Character.find(params[:id])

    @character.destroy

    redirect_to characters_path
  end

  def fetch
    characters = current_user.characters.select(:id, :name).where(world_id: Current.world.id).order(:updated_at)

    respond_to do |format|
      format.json { render json: characters }
    end
  end

  def create_instance
    Character.find(params[:id]).create_instance(current_user.id, params[:document_id], params[:order])

    redirect_to document_path(params[:document_id])
  end

  private

  def character_params
    params.require(:character).permit(:name, :description, :document_id, custom_field_values: {})
  end
end
