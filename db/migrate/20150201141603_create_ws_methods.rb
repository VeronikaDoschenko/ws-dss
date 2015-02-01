class CreateWsMethods < ActiveRecord::Migration
  def change
    create_table :ws_methods do |t|
      t.string :name
      t.string :code
      t.string :test_input
      t.string :test_output
      t.timestamps null: false
    end
    add_index :ws_methods, :name, :unique => true
  end
end
