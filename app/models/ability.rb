class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.admin?
      can :manage, :all
    else
      can :show_content, Document
      
      can :index, :modeling
      
      can :update, WsModelRun, :user_id => user.id
      can :read, WsModelRun, :user_id => user.id
      
      can [:update,:destroy,:read], WsModel, :user_id => user.id
      can :read, WsModel do |ws_model|
        a = user.roles.collect{|x| x.name} + %w[ public ]
        b = ws_model.roles.collect{|x| x.name}
        (a & b).size > 0
      end
    end
    if user.model_creator?
      
      can :manage, WsParam
      can :read,   WsModelStatus
      can :manage, WsParamModel
      can :manage, WsParamValue
      can :manage, WsSetModelRun
      can :read,   WsModelRun
      can :manage, WsSetModelRun, :user_id => user.id
      
      can :create, WsModel
      can :set_model_permission, WsModelRun
      can :set_model_permission, WsModel
    end
  end
end
