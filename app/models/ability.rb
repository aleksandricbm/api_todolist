class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    user ||= User.new # guest user (not logged in)
    if user.persisted?
      can :manage, Project, user_id: user.id
      can :manage, Task, project: { user_id: user.id }
    #   else
    #     can :read, :all
    end
  end
end
