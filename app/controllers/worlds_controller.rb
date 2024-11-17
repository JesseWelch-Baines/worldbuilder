class WorldsController < ApplicationController
  def index
    @worlds = current_user.worlds
  end

  def show
    @world = current_user.worlds.find(params[:id])
  end

  def new
    @world = current_user.worlds.new
  end

  def create
    world = current_user.worlds.new(world_params)

    respond_to do |format|
      if world.save
        session[:world_id] = world.id if params[:callback].present?
        format.html { redirect_to params[:callback] || worlds_path, notice: "#{world.name} created" }
      else
        format.html do
          redirect_to params[:callback] || worlds_path, notice: world.errors.full_messages.map { |msg|
            "World couldn't be saved: #{msg}"
          }
        end
      end
    end
  end

  def edit
    @world = current_user.worlds.find(params[:id])
  end

  def update
    @world = current_user.worlds.find(params[:id])

    if @world.update(world_params)
      redirect_to worlds_path
    else
      respond_to do |format|
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @world = World.find(params[:id]).destroy

    redirect_to worlds_path
  end

  private

  def world_params
    params.require(:world).permit(:name)
  end
end
