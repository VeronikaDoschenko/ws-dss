class AddSetToWsModelRuns < ActiveRecord::Migration
  def change
    add_reference :ws_model_runs, :ws_set_model_run, index: true, foreign_key: true
  end
end
