class AddIsCopyToWsParamModels < ActiveRecord::Migration
  def change
    add_column :ws_param_models, :is_copy, :boolean
  end
end
