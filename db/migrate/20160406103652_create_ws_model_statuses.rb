class CreateWsModelStatuses < ActiveRecord::Migration
  def change
    create_table :ws_model_statuses do |t|
      t.string :name

      t.timestamps null: false
    end
    WsModelStatus.create([
                          {name: 'Черновик'},
                          {name: 'Новая'},
                          {name: 'Идет прогон'},
                          {name: 'Прогон завершен'},
                          {name: 'Недопустимые параметры'},
                          {name: 'Ошибка выполнения'}
                         ]
                        )
    
  end
end
