class AddNewWsModelStatus < ActiveRecord::Migration
  def change
    WsModelStatus.create(name: 'Подготовка исходных данных') 
  end
end
