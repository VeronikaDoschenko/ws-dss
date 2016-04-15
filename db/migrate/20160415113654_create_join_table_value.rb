class CreateJoinTableValue < ActiveRecord::Migration
  def change
    create_join_table :ws_params, :ws_param_values do |t|
      t.index [:ws_param_value_id, :ws_param_id], name: 'index_param_value_source_link'
    end
  end
end
