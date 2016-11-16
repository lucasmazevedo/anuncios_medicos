class Category < ApplicationRecord
	has_many :ads

	def to_label
    	"#{description}"
  	end
end
