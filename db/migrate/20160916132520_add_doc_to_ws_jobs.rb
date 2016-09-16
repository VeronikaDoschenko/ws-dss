class AddDocToWsJobs < ActiveRecord::Migration
  def change
    add_column :ws_jobs, :filename, :string
    add_column :ws_jobs, :content_type, :string
    add_column :ws_jobs, :file_contents, :binary
  end
end
