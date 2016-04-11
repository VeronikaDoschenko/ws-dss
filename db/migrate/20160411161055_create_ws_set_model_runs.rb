class CreateWsSetModelRuns < ActiveRecord::Migration
  def change
    create_table :ws_set_model_runs do |t|
      t.string :name
      t.string :descr

      t.timestamps null: false
    end
  end
end
