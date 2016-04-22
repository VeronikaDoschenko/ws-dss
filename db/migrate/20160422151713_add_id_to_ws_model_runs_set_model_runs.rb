class AddIdToWsModelRunsSetModelRuns < ActiveRecord::Migration
  def change
    add_column :ws_model_runs_set_model_runs, :id, :primary_key
  end
end
