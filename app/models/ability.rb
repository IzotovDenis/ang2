class Ability
  include CanCan::Ability

  def initialize(user)
    @user = user || User.new # for guest

    if @user.id == nil
      can :read, Item #for guest without roles
      can :view_price, Item
    else
      send(@user.role)
    end

  end

  def buyer
    user
    can :set, :discount
    can :view_price, Item
    can [:index,:show,:modal_order], Order do |order|
      order.user_id == @user.id 
    end
    can [:forwarding], Order do |order|
      order.user_id == @user.id && order.formed = nil
    end
    can [:create], OrderItem
    can [:update,:destroy], OrderItem do |order_item|
      order_item.order.user_id == @user.id && order_item.order.formed == nil
    end
  end

  def user
    can :read, Item
    cannot :manage, User
    can [:show, :update], User do |current_user|
      current_user.id == @user.id
    end
  end
  
  def retail
    buyer
    cannot :set, :discount
  end 

  def manager
    superbuyer
  end

  def admin
    can :manage, :all
  end

  def dev
    admin
  end
end
