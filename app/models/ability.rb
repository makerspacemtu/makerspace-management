class Ability
  include CanCan::Ability

  # for more information on permissions read the documentation for cancancan:
  # https://github.com/CanCanCommunity/cancancan
  def initialize(user)
    # a user is required, we don't allow non-authenticated users
    return unless user.present?

    if user.admin?
      # admins can see any user
      can :read, User
      # admins can edit & udate any user
      can :edit, User
      can :update, User
      # admins can create new users
      can :create, User
      # admins can change anyones password (might want to change in the future)
      can :password, User
      can :update_password, User
      # only admins can see punches
      can :read, Punch
      # only admins can modify the actual trainings themselves
      can :read, Training
      can :edit, Training
      can :create, Training
      can :update, Training
      can :destroy, Training
      # admins can see, create and remove user trainings
      can :read, UserTraining
      can :create, UserTraining
      can :destroy, UserTraining
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

      can :read, UserSignup
      can :destroy, UserSignup
      can :create, UserSignup

    elsif user.staff?
      # staff can see any user
      can :read, User
      # staff can only edit & update themselves
      can :edit, User, id: user.id
      can :update, User, id: user.id
      can :update_password, User, id: user.id
      can :password, User, id: user.id
      # staff can see, create and remove user trainings for everyone
      can :read, UserTraining
      can :create, UserTraining
      can :destroy, UserTraining
      can :metrics, User
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

    end
    # members cannot currently do anything
  end
end
