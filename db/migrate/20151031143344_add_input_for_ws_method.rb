class AddInputForWsMethod < ActiveRecord::Migration
  def change
    add_column :ws_methods, :input, :string
  end
end
