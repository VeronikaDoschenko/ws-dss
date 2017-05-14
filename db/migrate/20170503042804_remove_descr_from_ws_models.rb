class RemoveDescrFromWsModels < ActiveRecord::Migration
  def change
  	Ws_models.each do |w|
  		dscr = Descriptions.new(
  			:descr => w.descr,
  			:locale => "ru",
  			:rec_id => w.id,
  			:rec_type => "WsModel"
  			)
  		dscr.save!
  	end
    remove_column :ws_models, :descr, :string
  end
end
