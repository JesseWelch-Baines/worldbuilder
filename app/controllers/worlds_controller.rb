class WorldsController < ApplicationController
  before_action :set_world, only: [:show, :edit, :update, :destroy]

  def index
    @worlds = current_user.worlds
  end

  def show; end

  def new
    @world = current_user.worlds.new
  end

  def edit; end

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

  def update
    if @world.update(world_params)
      redirect_to worlds_path
    else
      respond_to do |format|
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @world.destroy

    respond_to do |format|
      format.html { redirect_to worlds_path, notice: "#{@world.name} deleted" }
      format.json { head :no_content }
    end
  end

  private

  def world_params
    params.require(:world).permit(:name)
  end

  def set_world
    @world = current_user.worlds.find(params[:id])
  end
end
