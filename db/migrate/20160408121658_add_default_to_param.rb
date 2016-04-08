class AddDefaultToParam < ActiveRecord::Migration
  def change
    change_column_default :ws_params, :dim, 0
  end
end
