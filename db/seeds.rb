	require 'open-uri'
	require 'fastimage'
	require 'nokogiri'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Site.spawn('http://www.happletea.com')
Site.spawn('http://www.explosm.net')
Site.spawn('http://www.harkavagrant.com')
Site.spawn('http://www.xkcd.com')
Site.spawn('http://www.twogag.com')
Site.spawn('http://www.goneintorapture.com')

# doc = Nokogiri::HTML(open('http://www.pastemagazine.com/blogs/lists/2013/12/the-13-best-webcomics-of-2013.html'))

# doc = doc.css('div.copy.entry').search('a')

# doc.each do |site|
# 	Site.spawn(site['href'])
# end

