class RemoveDescrFromWsSetModelRuns < ActiveRecord::Migration
  def change
    remove_column :ws_set_model_runs, :descr, :string
  end
end
