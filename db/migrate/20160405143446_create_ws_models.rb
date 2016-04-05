class CreateWsModels < ActiveRecord::Migration
  def change
    create_table :ws_models do |t|
      t.string :name
      t.string :descr
      t.string :url

      t.timestamps null: false
    end
  end
end
