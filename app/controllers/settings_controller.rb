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

  def toggle_admin_view

    if Setting.admin_view == "disabled"
      Setting.admin_view = "enabled"
      redirect_to signups_path, notice: 'Admin view enabled.'
    else
      Setting.admin_view = "disabled"
      redirect_to signups_path, notice: 'Admin view disabled.'
    end

  end

  def toggle_deficient_trainings_view
    if Setting.deficient_trainings_view == "disabled"
      Setting.deficient_trainings_view = "enabled"
      redirect_to signups_path, notice: 'Now showing deficient trainings.'
    else
      Setting.deficient_trainings_view = "disabled"
      redirect_to signups_path, notice: 'Deficient trainings hidden.'
    end
    @deficient_trainings_view = Setting.deficient_trainings_view
  end

end
