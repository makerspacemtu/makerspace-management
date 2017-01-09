class CheckinController < ApplicationController
  def index
  end

  def checkin
    email = checkin_params[:email].downcase + "@mtu.edu"

    unless email.present? && valid_email?(email)
      # we currently only allow checking in and out with school emails
      redirect_to checkin_path, notice: "Invalid email. You must use a @mtu.edu email."
      return
    end

    user = User.find_by(email: email)

    unless user.present?
      first_name = checkin_params[:first_name]
      last_name = checkin_params[:last_name]

      # we need to create a user record, but first need more data
      if first_name.present? && last_name.present?
        # create the user with the information provided, with a random password
        # and only member status (least privilege)
        user = User.new(
          email: email,
          first_name: first_name,
          last_name: last_name,
          member_since: Time.now,
          password: Devise.friendly_token,
          user_type: 'Member'
        )

        unless user.save
          redirect_to checkin_path, notice: "An unexpected error occurred. Please try again."
          return
        end
      else
        # we're missing information, request the information from the user
        if (!first_name.nil? && first_name.empty?) || (!last_name.nil? && last_name.empty?)
          # the user left at least one of the name fields blank, provide a bit of help
          redirect_to checkin_first_time_path(email: checkin_params[:email]), notice: "Both first and last name are required fields."
        else
          redirect_to checkin_first_time_path(email: checkin_params[:email])
        end
        return
      end
    end

    last_punch = user.most_recent_punch
    if last_punch.present? && last_punch.in?
      # the user was checked in, we need to check them out
      user.punch_out
      redirect_to checkin_path, notice:"Thanks #{user.first_name}! You've been checked out."
      return
    else
      # this is the user's first time, or they were checked out last, check them in
      user.punch_in
      redirect_to checkin_path, notice: "Thanks #{user.first_name}! You've been checked in."
      return
    end
  end

private

  def checkin_params
    params.permit(:email, :first_name, :last_name)
  end

  def valid_email?(email)
    email.ends_with?('@mtu.edu')
  end
end
