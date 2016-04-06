class CreateWsParamModels < ActiveRecord::Migration
  def change
    create_table :ws_param_models do |t|
      t.references :ws_model, index: true, foreign_key: true
      t.references :ws_param, index: true, foreign_key: true
      t.boolean :is_required

      t.timestamps null: false
    end
  end
end
