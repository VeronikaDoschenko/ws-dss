class AddIdToWsParamValuesParams < ActiveRecord::Migration
  def change
    add_column :ws_param_values_params, :id, :primary_key
  end
end
