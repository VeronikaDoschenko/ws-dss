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
      
      can [:update,:destroy,:read], WsModel, :user_id => user.id
      can :read, WsModel,
          :id => ActiveRecord::Base.connection.execute(
                 "select distinct rc.roleable_id from royce_connector rc
                  where rc.roleable_type = 'WsModel' and 
                        ( rc.role_id = (select id from royce_role where name = 'public') or 
                          rc.role_id in (select rcu.role_id
                                         from royce_connector rcu
                                         where rcu.roleable_type = 'User' and
                                         rcu.roleable_id=#{user.id})
                        )").collect{|x| x["roleable_id"].to_i}   
      
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
      can :read, WsModelRun,
          :id => ActiveRecord::Base.connection.execute(
                 "select distinct rc.roleable_id from royce_connector rc
                  where rc.roleable_type = 'WsModelRun' and 
                        ( rc.role_id = (select id from royce_role where name = 'public') or 
                          rc.role_id in (select rcu.role_id
                                         from royce_connector rcu
                                         where rcu.roleable_type = 'User' and
                                         rcu.roleable_id=#{user.id})
                        )").collect{|x| x["roleable_id"].to_i}
          
      can :create, WsSetModelRun 
      can [:update,:destroy,:read], WsSetModelRun, :user_id => user.id 
      
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
