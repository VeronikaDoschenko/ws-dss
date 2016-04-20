class AddWsMethodRefToWsModels < ActiveRecord::Migration
  def change
    add_reference :ws_models, :ws_method, index: true, foreign_key: true
  end
end
