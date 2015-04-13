class Description < ActiveRecord::Base
  belongs_to :rec, polymorphic: true
end
