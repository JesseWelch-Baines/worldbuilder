class MentionsController < ApplicationController
  def index
    puts "+========"
    @characters = current_user.characters.where(world_id: Current.world.id)
    @locations = current_user.locations.where(world_id: Current.world.id)
    @items = current_user.items.where(world_id: Current.world.id)
    @events = current_user.events.where(world_id: Current.world.id)

    respond_to do |format|
      format.json
    end
  end
end
