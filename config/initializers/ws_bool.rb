class TrueClass
	def impl( other )
	  other 
	end
	def equviv( other )
	  other
	end
	def pirs( other )
	  false 
	end
	def sheph( other )
	  not other
	end
end

class FalseClass
	def impl( other )
	  true
	end
	def equviv( other )
	  not other 
	end
	def pirs( other )
	  not other 
	end
	def sheph( other )
	  true
	end
end
