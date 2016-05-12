class AddGoalWsModelRunToWsModelRuns < ActiveRecord::Migration
  def change
    add_reference :ws_model_runs, :goal_ws_model_run, references: :ws_model_runs, index: true
    add_foreign_key :ws_model_runs, :ws_model_runs, column: :goal_ws_model_run_id
  end
end
