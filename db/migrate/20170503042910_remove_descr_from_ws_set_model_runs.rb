class RemoveDescrFromWsSetModelRuns < ActiveRecord::Migration
  def change
  	Ws_SetModelRuns.each do |w|
  		dscr = Descriptions.new(
  			:descr => w.descr,
  			:locale => "ru",
  			:rec_id => w.id,
  			:rec_type => "WsSetModelRuns"
  			)
  		dscr.save!
  	end
    remove_column :ws_set_model_runs, :descr, :string
  end
end
