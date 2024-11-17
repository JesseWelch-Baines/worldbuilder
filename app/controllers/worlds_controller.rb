class WorldsController < ApplicationController
  def create
    world = current_user.worlds.new(name: params[:world][:name])

    respond_to do |format|
      if world.save
        session[:world_id] = world.id
        format.html { redirect_to params[:callback], notice: "#{world.name} created" }
      else
        format.html { redirect_to params[:callback], notice: world.errors.full_messages.map { |msg| "World couldn't be saved: #{msg}" } }
      end
    end
  end
end
