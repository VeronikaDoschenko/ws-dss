class CreateWsJobs < ActiveRecord::Migration
  def change
    create_table :ws_jobs do |t|
      t.text :input
      t.text :output
      t.integer :ws_method_id
      t.integer :user_id
      t.timestamps null: false
    end
    add_foreign_key :ws_jobs, :ws_methods
    add_foreign_key :ws_jobs, :users

    add_column :users, :numjobs, :integer, default: 10, null: false
  end
end
