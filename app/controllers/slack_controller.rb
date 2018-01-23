class SlackController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => [:checkout, :checkin]

  def checkin
      user = User.find_by(slack_user_id: params[:user_id])
      text = params[:text]

      if user.present?
        # If the user who ran the command has slack tied to their account
        if text.blank? || text == "me"
          # Trying to check themselves in
          last_punch = user.most_recent_punch
          if !last_punch.present? || last_punch.out?
            # the user was checked out, we need to check them in
            user.punch_in!
            msg = {"text":"Welcome to the space."}
          else
            msg = {"text":"You were already here!"}
          end
        else
          msg = {"text":"I'm not really sure what you were trying to do there."}
        end

      else
        msg = {"text":"Sorry, you don't seem to have your Slack profile in our system."}
      end
      render json: msg, status: :ok
  end

  def checkout
    user = User.find_by(slack_user_id: params[:user_id])
    text = params[:text]

    if user.present?
      # If the user who ran the command has slack tied to their account
      if text.blank? || text == "me"
        # Trying to check themselves out
        last_punch = user.most_recent_punch
        if last_punch.present? && last_punch.in?
          # the user was checked in, we need to check them out
          user.punch_out
          msg = {"text":"You have been punched out of the space."}
        else
          msg = {"text":"You were never punched in to the space."}
        end
      elsif text == "all"
        if user.admin?
          # admins can K-O anyone
          User.checked_in_users.each { |u| u.punch_out }
          msg = {"text":"All staff members and makers have been punched out. :punch:"}
        else
          msg = {"text":"Sorry, you don't have the ability to punch everyone out."}
        end
      else
        msg = {"text":"I'm not really sure what you were trying to do there."}
      end
    else
      msg = {"text":"Sorry, you don't seem to have your Slack profile in our system."}
    end
    render json: msg, status: :ok
  end

  def auth

  end

  def buttons

  end

  def events

  end
end
