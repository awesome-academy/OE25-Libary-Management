class Ability
  include CanCan::Ability

  def initialize user
    if user == User.new
      can :read, Book
      can :show, Category
    elsif user.admin?
      can :manage, :all
    else
      can [:read, :destroy], BorrowedDetail, borrowed: {user_id: user.id}
      can [:create, :update, :destroy], Borrowed, user_id: user.id
      can [:create, :destroy], Comment, user_id: user.id
      can [:read, :create, :update], User, user_id: user.id
      can :read, Book
    end
  end
end
