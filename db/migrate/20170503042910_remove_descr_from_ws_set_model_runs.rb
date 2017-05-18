class RemoveDescrFromWsSetModelRuns < ActiveRecord::Migration
  def change
    rename_column :ws_set_model_runs, :descr, :descripion
    
  	WsSetModelRun.all.each do |w|
  		dscr = Description.new(
  			:descr => w.descripion,
  			:locale => "ru",
  			:rec_id => w.id,
  			:rec_type => "WsSetModelRun"
  			)
  		dscr.save!
  	end
    remove_column :ws_set_model_runs, :descripion, :string
  end
end
