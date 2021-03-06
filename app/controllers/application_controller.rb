class ApplicationController < ActionController::Base
  include Utilities

  before_action :authenticate_user!
  before_action :check_or_create_world
  before_action :set_worlds
  before_action :check_access, only: :show

  def main
    @records = current_user.documents.includes(:writable_instances).where(world_id: Current.world.id)
    @records += current_user.paragraphs.where(world_id: Current.world.id).active
    @records += current_user.characters.where(world_id: Current.world.id)
    @records += current_user.locations.where(world_id: Current.world.id)
    @records += current_user.items.where(world_id: Current.world.id)
    @records += current_user.events.where(world_id: Current.world.id)
    @records.sort_by!(&:updated_at).reject! { |r| r.name.blank? }
  end

  def check_or_create_world
    return unless current_user.present?

    if session[:world_id].present?
      session_world = World.find_by(id: session[:world_id])

      if session_world.present?
        Current.world = session_world.user_id == current_user.id ? session_world : current_user.worlds.create(name: 'My World')
      else
        Current.world = current_user.worlds.any? ? current_user.worlds.order(:created_at).first : current_user.worlds.create(name: 'My World')
      end
    else
      Current.world = current_user.worlds.any? ? current_user.worlds.order(:created_at).first : current_user.worlds.create(name: 'My World')
    end
  end

  def set_worlds
    @worlds = current_user.worlds.where.not(id: Current.world.id).order(:created_at) if current_user.present?
  end

  def check_access
    return unless params[:id].present?

    begin
      object = params[:controller].singularize.camelize.constantize.find(params[:id])
      redirect_to root_path unless object.user_id == current_user.id
    rescue StandardError
      redirect_to root_path
    end
  end

end
