class Site < ActiveRecord::Base
	require 'open-uri'
	require 'fastimage'
	require 'nokogiri'

	has_many :users_sites
	has_many :users, through: :users_sites

	def self.update_all
		Site.all.each do |site|
			puts site.site_url
			site.update_database_entry(site)
		end
	end
	
	def self.spawn(site)
		nokogiri = Nokogiri::HTML(open(site))
		new_site = Site.new
		data_set = new_site.data_hash(site, nokogiri)
		new_site = Site.new(data_set)
		new_site.find_image_from_site(new_site, nokogiri)
		new_site.save
	end
	
	def data_hash(site, nokogiri)
		site_data = {
			site_url: site,
			picture_url: get_biggest_picture(site, get_domain(site), nokogiri)[1],
			orig_pic_url: get_biggest_picture(site, get_domain(site), nokogiri)[0],
			domain: get_domain(site),
			title: get_title(nokogiri)
		}
	end

	def image_size(picture)
		FastImage.size(picture) != nil ? FastImage.size(picture).inject(:*) : 0
	end

	def get_biggest_picture(site, domain, nokogiri)
		image_elements = nokogiri.search('img')
		@images = image_elements.map{ |item| item.attributes["src"].value }
		indexed_images = @images.each_with_index.map{|img, index| [index, url_shortener_filter(img, domain)]}
		domain_filter = domain_filter(domain, indexed_images)
		w_filter = domain_filter.select{|img| wonder_filter(img[1])}
		w_filter.map!{|img| [img[0], http_filter(img[1])]}
		w_filter.sort!{|a,b| image_size(b[1]) <=> image_size(a[1])}
		winning_combo = w_filter.first
		winning_combo = [@images[winning_combo[0]], winning_combo[1]]
		winning_combo
	end

	def get_domain(site)
		site[/(?<=\.)[^_]+(?=\.)/]
	end

	def get_title(nokogiri)
		nokogiri.search('title').children[0].text
	end

	def class_id_formatter(site)
		classes = site.classes == nil ? "" : ".#{site.classes}"
		ids = site.ids == nil ? "" : "##{site.ids}"
		"#{site.container}#{classes}#{ids}"
	end

	def update_database_entry(site)
		search_query = site.class_id_formatter(site)
		doc = Nokogiri::HTML(open(site.site_url)).search(search_query)
		new_image = site.container != "img" ? doc.search('img')[0]['src'] : doc[0]['src']
		site.orig_pic_url = new_image
		site.picture_url = site.filter_package(site)
		site.save
	end

	def find_image_from_site(site, nokogiri)
		doc = nokogiri.search('img')
		image = doc.select{|img|img.attributes['src'].value == site.orig_pic_url}[0]
		site.class_id_container_parent(site, image)
	end

	def class_id_container_parent(site, nokogiri)
		until site.class_or_id_labeled(nokogiri)
			nokogiri = nokogiri.parent
		end
		site.update_site(site, nokogiri)
	end

	def class_or_id_labeled(nokogiri)
		nokogiri.attributes.include?("class") || nokogiri.attributes.include?("id")
	end

	def update_site(site, nokogiri)
		site.classes = nokogiri["class"]
		site.ids = nokogiri["id"]
		site.container = nokogiri.name
		site.save
	end

	def url_shortener_filter(site, domain)
		site.include?('..') ? ("http://www." + domain + ".com" + site[/(?<=\.\.).*/]) : site
	end

	def domain_filter(domain, sites)
		filtered = sites.select{|site| site[1].include? domain}
		filtered != [] ? filtered : sites
	end

	def wonder_filter(site)
		!site.include?('projectwonderful')
	end

	def http_filter(site)
		site.include?('http:') ? site : "http:#{site}"
	end

	def filter_package(site)
		domain = site.domain
		url = site.orig_pic_url
		url_shortened = url_shortener_filter(url, domain)
		domain_filtered = domain_filter(domain, [[0,url_shortened]])
		http_filtered = http_filter(domain_filtered[0][1])
		http_filtered
	end
end