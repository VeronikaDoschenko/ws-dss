class RemoveDescrFromWsModels < ActiveRecord::Migration
  def change
    rename_column :ws_models, :descr, :descripion

  	WsModel.all.each do |w|
  		dscr = Description.new(
  			:descr => w.descripion,
  			:locale => "ru",
  			:rec_id => w.id,
  			:rec_type => "WsModel"
  			)
  		dscr.save!
  	end
    remove_column :ws_models, :descripion, :string
  end
end
