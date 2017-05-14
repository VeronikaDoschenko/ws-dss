class WsSetModelRun < ActiveRecord::Base
  include DescriptionsModule
  nilify_blanks

  has_many :ws_model_runs_set_model_runs, :dependent => :destroy
  has_many :ws_model_runs, through: :ws_model_runs_set_model_runs
  has_many :ws_param_values
  belongs_to :user
  
  royce_roles %w[ public ] + User.available_roles.collect{|s| s.name} - %w[ admin ]
  
  accepts_nested_attributes_for :ws_model_runs_set_model_runs, :allow_destroy => true

  validates :name, presence: true
  
end
