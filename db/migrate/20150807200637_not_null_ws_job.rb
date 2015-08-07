class NotNullWsJob < ActiveRecord::Migration
  def change
    change_column_null :ws_jobs, :ws_method_id, false
    change_column_null :ws_jobs, :user_id, false
  end
end
