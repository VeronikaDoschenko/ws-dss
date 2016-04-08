class AddUserToModel < ActiveRecord::Migration
  def change
    add_reference :ws_models, :user, index: true, foreign_key: true
    add_reference :ws_model_runs, :user, index: true, foreign_key: true
    add_reference :ws_params, :user, index: true, foreign_key: true
  end
end
