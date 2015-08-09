class AddCodeForWsJobs < ActiveRecord::Migration
  def change
    add_column :ws_jobs, :error_code, :integer, default: 0, null: false
    add_column :ws_jobs, :for_check,  :integer, default: 0, null: false
  end
end
