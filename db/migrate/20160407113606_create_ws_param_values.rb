class CreateWsParamValues < ActiveRecord::Migration
  def change
    create_table :ws_param_values do |t|
      t.references :ws_param, index: true, foreign_key: true
      t.references :ws_model_run, index: true, foreign_key: true
      t.string :old_value
      t.string :new_value

      t.timestamps null: false
    end
  end
end
