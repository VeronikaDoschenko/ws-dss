class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  #  :omniauthable, :lockable, :timeoutable
  devise :database_authenticatable, :registerable, :confirmable, 
         :recoverable, :rememberable, :trackable, :validatable
         
  has_many :ws_jobs, dependent: :destroy

  before_save :ensure_authentication_token

  royce_roles %w[ user admin ]

  def ensure_authentication_token
    self.authentication_token ||= generate_authentication_token
  end

  def get_sloved
    ws_jobs.where("error_code=0 and for_check=1").distinct.count(:ws_method_id)
  end

  def get_teams
    r = ActiveRecord::Base.connection.execute "SELECT DISTINCT (input)::json->>'team' a
           FROM ws_jobs WHERE (is_json(input)) and user_id=#{self.id}"
    r.select{|x| x["a"]}.collect{|x| x['a']}
  end

  private

  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end
  
end
