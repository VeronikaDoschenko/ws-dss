class AddTargetWsModelToWsModelRuns < ActiveRecord::Migration
  def change
    add_reference :ws_model_runs, :target_ws_model, references: :ws_models, index: true
    add_foreign_key :ws_model_runs, :ws_models, column: :target_ws_model_id
  end
end
