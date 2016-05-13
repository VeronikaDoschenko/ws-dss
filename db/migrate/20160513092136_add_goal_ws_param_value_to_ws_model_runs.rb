class AddGoalWsParamValueToWsModelRuns < ActiveRecord::Migration
  def change
    add_reference   :ws_model_runs, :goal_ws_param_value, references: :ws_param_values, index: true
    add_foreign_key :ws_model_runs, :ws_param_values, column: :goal_ws_param_value_id
  end
end
