class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    
    user.id = -666 if user.id.nil?
    
    if user.admin?
      can :manage, :all
    else
      if user.teacher?
        can :manage, Student
        can :read, WsJob
        can :show_content, WsJob
      end
      
      can :read, WsMethod
      
      can :create, WsJob 
      can [:update,:destroy,:read], WsJob, :user_id => user.id
      can [:show_content,:file_form,:file_save], WsJob, :user_id => user.id
      
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
      can :read, WsParam,
          :id => ActiveRecord::Base.connection.execute(
                 "select distinct wpm.ws_param_id
                  from ws_param_models wpm  
                       join ws_models wm on wm.id = wpm.ws_model_id
                       left outer join royce_connector rc on wm.id = rc.roleable_id and rc.roleable_type = 'WsModel'
                  where (rc.role_id = (select id from royce_role where name = 'public') or 
                         rc.role_id in (select rcu.role_id
					                    from   royce_connector rcu
					                    where  rcu.roleable_type = 'User' and
							            rcu.roleable_id = #{user.id}) or
                         wm.user_id = #{user.id}
                        )").collect{|x| x["ws_param_id"].to_i}
          
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
          
      
      can :create, WsParamValue
      can [:update,:destroy,:read], WsParamValue,
        :ws_model_run_id => WsModelRun.where(user_id: user.id).pluck(:id)
        
      can [:update,:destroy,:read], WsParamValue,
        :ws_model_run_id => WsModel.where(user_id: user.id).includes(:ws_model_runs).pluck('ws_model_runs.id')
        
	    can :read, WsParamValue,
          :ws_model_run_id => ActiveRecord::Base.connection.execute(
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
      can :read, WsSetModelRun,
          :id => ActiveRecord::Base.connection.execute(
                 "select distinct rc.roleable_id from royce_connector rc
                  where rc.roleable_type = 'WsSetModelRun' and 
                        ( rc.role_id = (select id from royce_role where name = 'public') or 
                          rc.role_id in (select rcu.role_id
                                         from royce_connector rcu
                                         where rcu.roleable_type = 'User' and
                                         rcu.roleable_id=#{user.id})
                        )").collect{|x| x["roleable_id"].to_i}
    end
    
    if user.model_creator?
      can :manage, WsParamModel 
      can :create, WsModel
      can :create, WsParam
      can :index,  :ws_params
      can :set_model_permission, WsModelRun
      can :set_model_permission, WsModel
      can :set_model_permission, WsSetModelRun
    end
    
  end
end
