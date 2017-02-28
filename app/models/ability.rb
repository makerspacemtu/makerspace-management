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
      # admins can see, create and remove user trainings
      can :read, UserTraining
      can :create, UserTraining
      can :destroy, UserTraining
      can :coaches, User
      can :metrics, User
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
    end
    # members cannot currently do anything
  end
end
