class AddOrdToWsParamValuesParams < ActiveRecord::Migration
  def change
    add_column :ws_param_values_params, :ord, :integer
  end
end
