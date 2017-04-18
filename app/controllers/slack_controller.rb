class SlackController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => [:checkout, :checkin, :training, :external]

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
            user.punch_in
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

  def training
    user = User.find_by(slack_user_id: params[:user_id])
    text = params[:text].split()

    emails = params[:text].scan(/[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}/i)
    usertags = params[:text].scan(/<[@#](U\w+)\|\w+>/)

    effected_users = User.where(slack_user_id: usertags) + User.where(email: emails)

    # If the user who ran the command has slack tied to their account
    if user.present?
      # refer to self if no other user is passed
      if effected_users.empty?
        effected_users = [user]
      end

      if text.blank? || text[0] == "list"
        attachments = []

        effected_users.each do |euser|
          fields = []

          euser.trainings.each do |training|
            fields << { "title":training.name, "short":"true" }
          end

          actions = [ {
             "name":"training add",
             "text":"Add training...",
             "type":"select",
             "data_source":"external"
            }, {
             "name":"taining remove",
             "text":"Remove training...",
             "type":"select",
             "data_source":"external"
            } ]

          if !user.member?
            attachments << { "title":euser.full_name, "fields":fields, "callback_id":euser.id, "actions":actions}
          else
            attachments << { "title":euser.full_name, "fields":fields}
          end
        end

        msg = {"text":"These are all the training that they have:", "attachments":attachments}
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

  def actions

  end

  def external
    action = params[:name].split()
    callback_id = params[:callback_id]
    user = User.where(id: callback_id).first
    options = []

    if action[0] == "training"
      if action[1] == "add"
        training = Training.all.where.not(id: user.trainings.pluck(:id))
      elsif action[1] == "remove"
        training = Training.all.where(id: user.trainings.pluck(:id))
      end

      training.each do |training|
        options << { "text": training.name, "value":training.id}
      end
    end

    render json: {"options":options}, status: :ok
  end

  def events

  end
end
