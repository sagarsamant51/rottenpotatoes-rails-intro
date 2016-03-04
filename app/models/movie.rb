class Movie < ActiveRecord::Base
	def self.get_all_rating
	#it's a class method
	Movie.select(:rating).uniq.map{|movie| movie.rating}.sort
	end
end
