class AddFormulaToWsParamValues < ActiveRecord::Migration
  def change
    add_column :ws_param_values, :formula, :string
  end
end
