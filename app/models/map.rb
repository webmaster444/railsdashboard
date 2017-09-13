class Map < ApplicationRecord	
	require 'csv'	
	enum status: [:published, :unpublished]
end
