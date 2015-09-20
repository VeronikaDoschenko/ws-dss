class Student < ActiveRecord::Base
  belongs_to :student_group

  def get_user
    User.find_by_email(self.email)
  end
end
