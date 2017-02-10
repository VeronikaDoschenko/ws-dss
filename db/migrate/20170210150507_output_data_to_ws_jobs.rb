class OutputDataToWsJobs < ActiveRecord::Migration
  def change
    add_column :ws_jobs, :output_data, :string
  end
end
