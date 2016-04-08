class AddUniqParamModel < ActiveRecord::Migration
  def change
    add_index :ws_param_models, [:ws_param_id, :ws_model_id], unique: true
    add_index :ws_param_values, [:ws_param_id, :ws_model_run_id], unique: true
  end
end
