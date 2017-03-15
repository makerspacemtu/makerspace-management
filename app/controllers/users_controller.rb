class UsersController < ApplicationController
  load_and_authorize_resource

  @@slack = Slack::Web::Client.new

  def index
    @users = User.order(:first_name, :last_name)
  end

  def coaches
    @users = User.where(user_type: ['Admin', 'Staff']).order(:first_name, :last_name)
  end

  def metrics
    @users_created_by_week = User.users_created_by_week
    @punches_created_by_week = Punch.punches_created_by_week
  end

  def show
    @user = User.find(params[:id])

    if @user.slack_user_id.present?
      @slack_username = @@slack.users_info(user: @user.slack_user_id)[:user][:name]
    end
  end

  def edit
    @user = User.find(params[:id])

    @slack_usernames = @@slack.users_list()[:members].map { |u| [u[:name], u[:id]] }
    @slack_usernames.insert(0, ["None", ""])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to @user, notice: 'User updated.'
    else
      render 'edit', error: @user.errors
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to @user, notice: 'User created.'
    else
      render 'new', error: @user.errors
    end
  end

  def update_password
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to @user, notice: 'Password updated.'
    else
      render 'password', error: @user.errors
    end
  end

  def password
    @user = User.find(params[:id])
  end

private

  def user_params
    params.require(:user).permit(permit_params)
  end

  def permit_params
    base =
      [:email,
      :biography,
      :first_name,
      :last_name,
      :slack_user_id,
      :facebook_username,
      :twitter_username,
      :github_username,
      :profile_image_url,
      :position_name,
      :password,
      :password_confirmation,
      :specialties,
      :interests
    ]

    if current_user && current_user.admin?
      base << :member_since
      base << :user_type
    end

    base
  end
end
