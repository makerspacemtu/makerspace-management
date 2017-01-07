class Ability
  include CanCan::Ability

  # for more information on permissions read the documentation for cancancan:
  # https://github.com/CanCanCommunity/cancancan
  def initialize(user)
    if user.admin?
      # admins can see any user
      can :read, User
      # admins can edit any user
      can :edit, User
    elsif user.staff?
      # staff can see any user
      can :read, User
      # staff can only edit themselves
      can :edit, User, id: user.id
    end
    # members cannot currently do anything
  end
end
