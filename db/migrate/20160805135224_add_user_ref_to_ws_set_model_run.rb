class AddUserRefToWsSetModelRun < ActiveRecord::Migration
  def change
    add_reference :ws_set_model_runs, :user, index: true, foreign_key: true
    user_id = User.find_by_id(1).try(:id)
    if user_id
      WsSetModelRun.update_all "user_id = #{user_id}" 
      WsModelRun.where( user_id: nil).update_all("user_id =  #{user_id}")
    end
  end
end
