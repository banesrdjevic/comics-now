	require 'open-uri'
	require 'fastimage'
	require 'nokogiri'
	doc = Nokogiri::HTML(open('http://www.pastemagazine.com/blogs/lists/2013/12/the-13-best-webcomics-of-2013.html'))

	doc = doc.css('div.copy.entry').search('a')

	doc.each do |site|
		
		Site.spawn(site['href'])
	end