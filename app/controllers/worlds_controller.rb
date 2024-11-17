class WorldsController < ApplicationController
  def index
    @worlds = current_user.worlds
  end

  def new
    @world = current_user.worlds.new
  end

  def create
    world = current_user.worlds.new(name: params[:world][:name])

    respond_to do |format|
      if world.save
        session[:world_id] = world.id
        format.html { redirect_to params[:callback], notice: "#{world.name} created" }
      else
        format.html do
          redirect_to params[:callback], notice: world.errors.full_messages.map { |msg|
            "World couldn't be saved: #{msg}"
          }
        end
      end
    end
  end
end
