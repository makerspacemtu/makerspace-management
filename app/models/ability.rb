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
    elsif user.staff?
      # staff can see any user
      can :read, User
      # staff can only edit & update themselves
      can :edit, User, id: user.id
      can :update, User, id: user.id
    end
    # members cannot currently do anything
  end
end
