class UsersController < ApplicationController
  load_and_authorize_resource

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update!(user_params)
    render 'edit'
  end

private

  def user_params
    params.require(:user).permit(
      :email,
      :biography,
      :first_name,
      :last_name,
      :slack_username,
      :facebook_username,
      :twitter_username,
      :github_username,
      :profile_image_url,
      :position_name
    )
  end
end
