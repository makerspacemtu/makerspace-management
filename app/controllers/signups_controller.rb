class SignupsController < ApplicationController
  load_and_authorize_resource

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
  end

  def create
    @signup = Signup.new(signup_params)

    if @signup.save
      redirect_to signups_path, notice: 'Shift Slot Created.'
    else
      render 'new'
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
    @signup.delete
    if @signup.destroy
      redirect_to signups_path, notice: 'Slot deleted.'
    else
      # render 'edit', error: @signup.errors
    end
  end

  def dropsignup
    # puts "HERE"
    # puts "HEREEE2: ##{dropsignup_params['signup_id']}"
    # puts "HEREEEE3: ##{dropsignup_params['user_id']}"
    if UserSignup.all.where(signup_id: dropsignup_params[:signup_id]).where(user_id: dropsignup_params[:user_id]).exists?
      user_signup = UserSignup.all.where(signup_id: dropsignup_params[:signup_id]).where(user_id: dropsignup_params[:user_id])
      # puts "HEREEEE4: ##{user_signup}"
    # user = User.find(params[:user_id])
      user_signup.first.delete
      redirect_to signups_path, notice: "Shift dropped."
    else
      redirect_to signups_path, notice: "Could not drop shift."
    end
  end

private
  def dropsignup_params
    params.permit(:signup_id,:user_id, :utf8, :authenticity_token, :commit)
  end
  def signup_params
    params.require(:signup).permit(:signup_day, :signup_start, :signup_end, :signup_qty)
  end
end
