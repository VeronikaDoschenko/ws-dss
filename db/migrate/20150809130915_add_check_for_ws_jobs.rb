class AddCheckForWsJobs < ActiveRecord::Migration
  def change
    add_column :ws_jobs, :do_check,  :integer, default: 0, null: false
  end
end
