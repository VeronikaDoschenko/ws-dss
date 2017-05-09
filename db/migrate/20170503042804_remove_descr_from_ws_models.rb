class RemoveDescrFromWsModels < ActiveRecord::Migration
  def change
    remove_column :ws_models, :descr, :string
  end
end
