class CreateJoinTableSet < ActiveRecord::Migration
  def change
    create_join_table :ws_model_runs, :ws_set_model_runs do |t|
      t.index [:ws_set_model_run_id, :ws_model_run_id], name: 'index_set_model_run_link'
    end
  end
end
