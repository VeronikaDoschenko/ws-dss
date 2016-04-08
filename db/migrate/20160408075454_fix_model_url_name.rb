class FixModelUrlName < ActiveRecord::Migration
  def change
    rename_column :ws_models, :url, :model_url
  end
end
