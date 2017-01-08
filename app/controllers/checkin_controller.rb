class CheckinController < ApplicationController
  def index
  end

  def checkin
    email = checkin_params['email']

    unless valid_email?(email)
      redirect_to checkin_path, notice: "Invalid email. You must use a @mtu.edu email."
      return
    end

    user = User.find_by(email: email)

    if user.present?
      redirect_to checkin_path, notice: "Good."
    else
      redirect_to checkin_path, notice: "You don't have an account yet."
    end
  end

private

  def checkin_params
    params.permit(:email)
  end

  def valid_email?(email)
    email.ends_with?('@mtu.edu')
  end
end
