class Ability
  include CanCan::Ability

  def initialize(user)
    can [:new,:create,:destroy], Session
    can :read, [Author,Keyword]
    can :index, Article
    can :show, Article, :private => false
    
    if user
      can [:create,:update,:destroy], [Author,Keyword]
      can [:new,:create], Article
      can [:edit,:update], Article, :private => false
      can [:show,:edit,:update,:download], Article, :group => {:memberships => {:roles_mask => 1..2, :user_id => user.id}}
      can :manage, Article, :group => {:memberships => {:roles_mask => 1, :user_id => user.id}}
      can :manage, Article, :owner_id => user.id

      can [:index,:new,:create], Group
      can :show, Group, :memberships => {:roles_mask => 1..2, :user_id => user.id}
      can [:edit,:update,:destroy,:invite_to], Group, :memberships => {:roles_mask => 1, :user_id => user.id}
    end

# can :update, Project, ["priority < ?", 3] do |project|
#   project.priority < 3
# end

    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
