class CreateDescriptions < ActiveRecord::Migration
  def change
    create_table :descriptions do |t|
      t.string :descr
      t.string :locale
      t.integer :rec_id
      t.string :rec_type

      t.timestamps null: false
    end
  end
end
