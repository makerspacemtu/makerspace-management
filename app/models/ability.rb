class Ability
  include CanCan::Ability

  # for more information on permissions read the documentation for cancancan:
  # https://github.com/CanCanCommunity/cancancan
  def initialize(user)
    # a user is required, we don't allow non-authenticated users
    return unless user.present?

    if user.admin?
      # admins have same permissions as developers
      # admins can see any user
      can :read, User
      # admins can edit & update any user
      can :edit, User
      can :update, User
      # admins can create new users
      can :create, User
      # admins can change anyones password (might want to change in the future)
      can :password, User
      can :update_password, User
      # admins can see punches
      can :read, Punch
      can :checkin_history, Punch
      # admins can modify the actual trainings themselves
      can :read, Training
      can :edit, Training
      can :create, Training
      can :update, Training
      can :destroy, Training
      # admins can see, create and remove user trainings
      can :read, UserTraining
      can :create, UserTraining
      can :destroy, UserTraining
      can :droptraining, Training
      can :nullifyagreements, Training

      can :coaches, User

      can :metrics, User
      can :destroy, User
      # admins have full access to daily reports
      can :read, DailyReport
      can :edit, DailyReport
      can :update, DailyReport
      can :create, DailyReport
      can :destroy, DailyReport
      # admins can edit and see their own shifts
      can :read, Signup
      can :destroy, Signup
      can :create, Signup
      can :edit, Signup
      can :update, Signup
      can :dropsignup, Signup

      can :read, UserSignup
      can :destroy, UserSignup
      can :create, UserSignup
      can :delete, UserSignup

      #admins can edit and create and destroy events
      can :read, Event
      can :destroy, Event
      can :create, Event
      can :edit, Event
      can :update, Event

      #admins can change signup settings
      can :toggle_signup_status, Setting
      can :toggle_admin_view, Setting
      can :toggle_deficient_trainings_view, Setting

      can :read, Survey
      # can :destroy, Survey
      can :create, Survey
      # can :edit, Survey
      # can :update, Survey

    elsif user.developer?
      # developers have same permissions as developers
      # developers can see any user
      can :read, User
      # developers can edit & update any user
      can :edit, User
      can :update, User
      # developers can create new users
      can :create, User
      # developers can change anyones password (might want to change in the future)
      can :password, User
      can :update_password, User
      # developers can see punches
      can :read, Punch
      can :checkin_history, Punch
      # developers can modify the actual trainings themselves
      can :read, Training
      can :edit, Training
      can :create, Training
      can :update, Training
      can :destroy, Training
      # developers can see, create and remove user trainings
      can :read, UserTraining
      can :create, UserTraining
      can :destroy, UserTraining
      can :droptraining, Training
      can :nullifyagreements, Training

      can :coaches, User
      can :metrics, User
      can :destroy, User
      # developers have full access to daily reports
      can :read, DailyReport
      can :edit, DailyReport
      can :update, DailyReport
      can :create, DailyReport
      can :destroy, DailyReport
      # developers can edit and see their own shifts
      can :read, Signup
      can :destroy, Signup
      can :create, Signup
      can :edit, Signup
      can :update, Signup
      can :dropsignup, Signup

      can :read, UserSignup
      can :destroy, UserSignup
      can :create, UserSignup
      can :delete, UserSignup

      #developers can edit and create and destroy events
      can :read, Event
      can :destroy, Event
      can :create, Event
      can :edit, Event
      can :update, Event

      #developers can change signup settings
      can :toggle_signup_status, Setting
      can :toggle_admin_view, Setting
      can :toggle_deficient_trainings_view, Setting

      can :read, Survey
      # can :destroy, Survey
      can :create, Survey
      # can :edit, Survey
      # can :update, Survey


    elsif user.staff?

      # staff can see any user
      can :read, User
      # staff can only edit & update themselves
      can :edit, User, id: user.id
      can :update, User, id: user.id
      can :update_password, User, id: user.id
      can :password, User, id: user.id

      # staff can view the actual trainings themselves
      can :read, Training

      # staff can see, create and remove user trainings for everyone
      can :read, UserTraining
      can :create, UserTraining
      can :destroy, UserTraining
      can :metrics, User
      can :droptraining, Training
      # staff can see and create daily reports
      can :read, DailyReport
      can :create, DailyReport
      # staff can edit their own daily reports
      can :edit, DailyReport, user_id: user.id
      can :update, DailyReport, user_id: user.id
      # staff can edit and see their own shifts
      can :read, Signup
      can :read, UserSignup
      can :destroy, UserSignup
      can :create, UserSignup
      can :dropsignup, Signup

      #staff can edit and create events
      can :read, Event
      can :create, Event
      can :edit, Event

      can :update, Event
      can :toggle_deficient_trainings_view, Setting

      can :create, Survey
      # can :update, Survey

    elsif user.member?
      can :create, Survey
      # can :update, Survey
    end

  end
end
