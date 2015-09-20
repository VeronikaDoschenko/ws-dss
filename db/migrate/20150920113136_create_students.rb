class CreateStudents < ActiveRecord::Migration
  def change
    create_table :student_groups do |t|
      t.string  :name
      t.integer :year
    end

    create_table :students do |t|
      t.string  :name
      t.string  :mname
      t.string  :lname
      t.string  :serial
      t.string  :email
      t.integer :student_group_id
    end

    add_foreign_key :students, :student_groups 
  end
end
