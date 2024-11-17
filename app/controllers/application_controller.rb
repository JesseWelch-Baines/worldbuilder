class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :authenticate_user!
  before_action :check_or_create_world
  before_action :set_worlds
  # before_action :check_access, only: :show

  def main
    @records = current_user.documents.includes(:article_instances).where(world_id: Current.world.id)
    @records += current_user.paragraphs.where(world_id: Current.world.id).active
    @records += current_user.articles.where(world_id: Current.world.id)
    @records.sort_by!(&:updated_at).reject! { |r| r.name.blank? }
  end

  def check_or_create_world
    return unless current_user.present?

    if session[:world_id].present?
      session_world = World.find_by(id: session[:world_id])

      Current.world = if session_world.present?
                        session_world.user_id == current_user.id ? session_world : current_user.worlds.create(name: "My World")
                      else
                        current_user.worlds.any? ? current_user.worlds.order(:created_at).first : current_user.worlds.create(name: "My World")
                      end
    else
      Current.world = current_user.worlds.any? ? current_user.worlds.order(:created_at).first : current_user.worlds.create(name: "My World")
    end
  end

  def set_current_world
    session[:world_id] = params[:world_id]

    callback = params[:callback] == "/worlds" ? root_path : params[:callback]

    redirect_to callback
  end

  private

  def set_worlds
    @worlds = current_user.worlds.where.not(id: Current.world.id).order(:created_at) if current_user.present?
  end
end
