class AddDescrToWsModelRuns < ActiveRecord::Migration
  def change
    add_column :ws_model_runs, :descr, :string
  end
end
