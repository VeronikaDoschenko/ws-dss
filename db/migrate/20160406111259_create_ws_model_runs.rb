class CreateWsModelRuns < ActiveRecord::Migration
  def change
    create_table :ws_model_runs do |t|
      t.string :name
      t.references :ws_model, index: true, foreign_key: true
      t.references :ws_model_status, index: true, foreign_key: true
      t.text :trace

      t.timestamps null: false
    end
  end
end
