class RemoveDescrFromWsParams < ActiveRecord::Migration
  def change
  	Ws_params.each do |w|
  		dscr = Descriptions.new(
  			:descr => w.descr,
  			:locale => "ru",
  			:rec_id => w.id,
  			:rec_type => "WsParams"
  			)
  		dscr.save!
  	end
    remove_column :ws_params, :descr, :string
  end
end
