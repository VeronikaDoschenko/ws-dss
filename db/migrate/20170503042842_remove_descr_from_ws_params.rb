class RemoveDescrFromWsParams < ActiveRecord::Migration
  def change
    remove_column :ws_params, :descr, :string
  end
end
