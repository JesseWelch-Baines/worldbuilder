class WorldsController < ApplicationController

  def index
    @worlds = current_user.worlds
  end

  def new
    @world = World.new
  end

  def create
    @world = current_user.worlds.new(world_params)

    if @world.save
      world_generator(@world.id, world_params[:gen_type], world_params[:gen_size].to_i) if world_params[:gen_type].present?
      session[:world_id] = @world.id
      redirect_to root_path
    else
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity}
      end
    end
  end

  def edit
    @world = World.find(params[:id])
  end

  def update
    @world = World.find(params[:id])

    if @world.update(world_params)
      redirect_to worlds_path
    else
      respond_to do |format|
        format.html { render :edit, status: :unprocessable_entity}
      end
    end
  end

  def show
    @world = World.includes(:documents, :paragraphs, :characters, :locations, :items, :events).find(params[:id])
  end

  def destroy
    @world = World.find(params[:id]).destroy

    redirect_to worlds_path
  end

  def create_from_nav
    world = current_user.worlds.new(name: params[:world][:name])

    respond_to do |format|
      if world.save
        session[:world_id] = world.id
        format.html {redirect_to params[:callback], notice: "#{world.name} created"}
      else
        format.html {redirect_to params[:callback], notice: world.errors.full_messages.map{|msg| "World couldn't be saved: #{msg}"}}
      end
    end
  end

  def change_to
    session[:world_id] = params[:id]

    redirect_to params[:callback]
  end

  def generate_elements
    world_generator(params[:id])

    redirect_to params[:callback]
  end

  private

  def world_generator(id, type, size)
    world_generator = Generators::WorldGenerator.new(current_user.id, id, type, size)
    world_generator.generate_structured
  end

  def world_params
    params.require(:world).permit(:name, :gen_type, :gen_size)
  end

end
