class AddWsSetModelRunRefToWsParamValues < ActiveRecord::Migration
  def change
    add_reference :ws_param_values, :ws_set_model_run, index: true, foreign_key: true
  end
end
