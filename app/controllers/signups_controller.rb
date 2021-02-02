class SignupsController < ApplicationController
  load_and_authorize_resource
  respond_to :html, :json

  def index
    @users = User.where(user_type: ['Admin', 'Staff']).order(first_name: :asc)
    @user_signup = UserSignup.new
    @user = current_user
  end

  def edit
    @signup = Signup.find(params[:id])
  end

  def new
    @user = current_user
    @signup = Signup.new

    respond_modal_with @signup
  end

  def create
      @signup = Signup.new(signup_params)
    if !(Signup.exists?(signup_day: @signup.signup_day, signup_start: @signup.signup_start))
      if @signup.save
        redirect_to signups_path, notice: 'Shift Slot Created.'
      else
        render 'new'
      end
    else
      redirect_to signups_path, notice: 'Shift Slot Exists.'
    end
  end

  def update
    @signup = Signup.find(params[:id])

    if @signup.update(signup_params)
      redirect_to signups_path, notice: 'Shift updated.'
    else
      render 'edit'
    end
  end

  def destroy
    @signup = Signup.find(params[:id])
    #if a signup slot is deleted, then also delete the associated user signups
    if UserSignup.where(signup_id: @signup.id).exists?
      UserSignup.where(signup_id: @signup.id).each do |user_signup|
        user_signup.delete
      end
    end
    @signup.delete
    if @signup.destroy
      redirect_to signups_path, notice: 'Slot deleted.'
    else
      redirect_to signups_path, notice: 'Error deleting slot.'
    end
  end

  def dropsignup
    if UserSignup.all.where(signup_id: dropsignup_params[:signup_id]).where(user_id: dropsignup_params[:user_id]).exists?
      user_signup = UserSignup.all.where(signup_id: dropsignup_params[:signup_id]).where(user_id: dropsignup_params[:user_id])
      user_signup.first.delete
      redirect_to signups_path, notice: "Shift dropped."
    else
      redirect_to signups_path, notice: "Could not drop shift."
    end
  end

  def clearusersignups
    #Clear out all the existing usersignups
    if UserSignup.all.exists?
      UserSignup.all.each do |user_signup|
        user_signup.delete
        puts user_signup
      end
    else
      redirect_to signups_path, notice: "No user signups currently exist."
      return
    end
    redirect_to signups_path, notice: "All current User Signups have been cleared."
  end

  def clearslots
    #Clear out all the existing usersignups
    if Signup.exists?
      Signup.destroy_all
    else
      redirect_to signups_path, notice: "No slots currently exist."
      return
    end
    redirect_to signups_path, notice: "All current slots have been cleared."
  end

private
  def dropsignup_params
    params.permit(:signup_id,:user_id, :utf8, :authenticity_token, :commit)
  end
  def signup_params
    params.require(:signup).permit(:signup_day, :signup_start, :signup_qty)
  end
end
