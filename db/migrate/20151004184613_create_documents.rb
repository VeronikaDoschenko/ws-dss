class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :name
      t.string :filename
      t.string :content_type
      t.binary :file_contents

      t.timestamps null: false
    end
  end
end
