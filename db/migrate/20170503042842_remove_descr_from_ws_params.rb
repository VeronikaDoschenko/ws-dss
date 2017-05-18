class RemoveDescrFromWsParams < ActiveRecord::Migration
  def change
    rename_column :ws_params, :descr, :descripion
    
  	WsParam.all.each do |w|
  		dscr = Description.new(
  			:descr => w.descripion,
  			:locale => "ru",
  			:rec_id => w.id,
  			:rec_type => "WsParam"
  			)
  		dscr.save!
  	end
    remove_column :ws_params, :descripion, :string
  end
end
