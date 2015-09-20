class AddTsStudentGroups < ActiveRecord::Migration
  def change
    change_table(:student_groups) do |t|
      t.timestamps
    end
    change_table(:students) do |t|
      t.timestamps
    end
    Student.update_all("created_at = now(), updated_at = now()")
    StudentGroup.update_all("created_at = getdate(), updated_at = getdate()")
  end
end
