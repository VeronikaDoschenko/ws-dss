class Translation < ActiveRecord::Base
	validates :key, uniqueness: { scope: [:value], message: "Not UNIQ" }
end
