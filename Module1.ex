require IEx;

defmodule Module1 do

	def fetchXML(url) do
		IEx.pry
		
	end

end

url = "playerservices.streamtheworld.com/api/livestream?station=TRITONRADIOMUSIC&transports=http%2Chls%2Chlsts&version=1.9"

Module1.fetchXML(url)
