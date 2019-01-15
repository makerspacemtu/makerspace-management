class UserSignupsController < ApplicationController
  load_and_authorize_resource

  def new
    @user_signups = Signup.all
    @user_signup = UserSignup.new
    @user = User.find(params[:user_id])

  end

  def create
    user = User.find(params[:user_id])
    signup = Signup.find(user_signup_params[:signup_id])

    if UserSignup.exists?(user: user, signup: signup)
      redirect_to new_user_user_signup_path(user), notice: 'Shift already taken.'
      return
    end

    @user_signup = UserSignup.new
    @user_signup.signup = signup
    @user_signup.user = user
    @user_signup.created_by = current_user

    if @user_signup.save
      redirect_to signups_path, notice: 'Signed up for shift.'
    else
      render 'new'
    end
  end

  def destroy
    @user_signup = UserSignup.find(params[:id])
    user = User.find(params[:user_id])

    if @user_signup.destroy
      redirect_to user_path(user), notice: 'User signup removed.'
      return
    else
      redirect_to user_path(user), notice: 'An error occurred trying to remove the user signup.'
      return
    end
  end

private

  def user_signup_params
    params.require(:user_signup).permit(:signup_id, :signup_day, :signup_start,:signup_qty)
  end
end
