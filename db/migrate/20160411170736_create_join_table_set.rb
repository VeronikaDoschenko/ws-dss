class CreateJoinTableSet < ActiveRecord::Migration
  def change
    create_join_table :model_runs, :set_model_runs do |t|
      t.index [:set_model_run_id, :model_run_id], :name => 'index_set_model_run_link'
    end
  end
end
