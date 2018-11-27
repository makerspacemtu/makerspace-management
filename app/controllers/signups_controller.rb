class SignupsController < ApplicationController
  load_and_authorize_resource

  def index

  end

  def edit
    @signup = Signup.find(params[:id])
  end

  def new
    @signup = Signup.new
  end

  def create
    @signup = Signup.new(signup_params)

    if @signup.save
      redirect_to signups_path, notice: 'Signed up for shift.'
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

private

  def signup_params
    params.require(:signup).permit(:signup_day, :signup_start, :signup_end, :signup_qty)
  end
end
