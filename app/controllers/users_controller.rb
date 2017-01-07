class UsersController < ApplicationController
  load_and_authorize_resource

  def index
    @users = User.order(:first_name, :last_name)
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to @user, notice: 'Profile updated.'
    else
      render 'edit', error: @user.errors
    end
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
