class MentionsController < ApplicationController
  def index
    @articles = current_user.articles

    respond_to do |format|
      format.json
    end
  end
end
