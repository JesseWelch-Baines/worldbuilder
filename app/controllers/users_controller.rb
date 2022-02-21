class UsersController < ApplicationController

  def show
  end

  def preferences_form
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)

    respond_to do |format|
      format.html {redirect_to preferences_form_user_path(@user), notice: "Preferences updated"}
    end
  end

  private
  def user_params
    params.require(:user).permit(:save_copy_of_paragraphs)
  end


end
