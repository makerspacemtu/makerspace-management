class SettingsController < ApplicationController
  load_and_authorize_resource

  def toggle_signup_status

    if Setting.signup_status == "closed"
      Setting.signup_status = "open"
      redirect_to signups_path, notice: 'Signups now open.'
    else
      Setting.signup_status = "closed"
      redirect_to signups_path, notice: 'Signups now closed.'
    end
    @signup_status = Setting.signup_status
  end
end
