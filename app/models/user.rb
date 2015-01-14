class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  #  :omniauthable, :lockable, :timeoutable
  devise :database_authenticatable, :registerable, :confirmable, 
         :recoverable, :rememberable, :trackable, :validatable
end
