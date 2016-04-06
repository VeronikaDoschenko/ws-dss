class CreateWsParams < ActiveRecord::Migration
  def change
    create_table :ws_params do |t|
      t.string :name
      t.string :descr
      t.boolean :is_int
      t.integer :dim
      t.decimal :min_val
      t.decimal :max_val

      t.timestamps null: false
    end
  end
end
