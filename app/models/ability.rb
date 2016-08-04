class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.admin?
      can :manage, :all
    else
      can :show_content, Document
      
      can :index, :modeling
      can :index, :ws_model_runs
      can :index, :ws_set_model_runs
      can :index, :ws_param_values
      
      can :update, WsModelRun, :user_id => user.id
      can :read, WsModelRun, :user_id => user.id
      
      can [:update,:destroy,:read], WsModel, :user_id => user.id
      can :read, WsModel do |ws_model|
        a = user.roles.collect{|x| x.name} + %w[ public ]
        b = ws_model.roles.collect{|x| x.name}
        (a & b).size > 0
      end
      
      can [:update,:destroy,:read], WsParam, :user_id => user.id
      can :read, WsParam do |ws_param|
        a = user.roles.collect{|x| x.name} + %w[ public ]
        b = WsModel.where(id:  WsParamModel.where(ws_param: ws_param).pluck(:ws_model_id)).
                    collect{|m| m.roles.pluck(:name)}.flatten.uniq
        (a & b).size > 0
      end
      
      can :read, WsModelStatus
 
      can :create, WsModelRun
      can [:update,:destroy,:read], WsModelRun, :user_id => user.id
       
      can :create, WsSetModelRun 
      can [:update,:destroy,:read], WsSetModelRun, :user_id => user.id #todo
      
    end
    if user.model_creator?
      can :manage, WsParamModel
      
      can :manage, WsParamValue #todo

      can :create, WsModel
      can :create, WsParam
      can :index,  :ws_params
      can :set_model_permission, WsModelRun
      can :set_model_permission, WsModel
    end
  end
end
