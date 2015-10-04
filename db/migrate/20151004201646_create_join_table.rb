class CreateJoinTable < ActiveRecord::Migration
  def change
    create_join_table :documents, :subjects do |t|
      t.index [:subject_id, :document_id]
    end
  end
end
