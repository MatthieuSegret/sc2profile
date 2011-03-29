require "rubygems"
require "bundler/setup"

require "nokogiri"
require 'open-uri'

class SC2League
	def initialize(name)
		index = LEAGUES.index(name)

		if not index.nil?
			@index = index
			@name = name
		end
	end

	LEAGUES = ["no league", "bronze", "silver", "gold", "platinum", "diamond", "master", "grand master"]
	
	def leagues
		@leagues
	end

	def to_s
		@name.capitalize
	end
end

class SC2Stats
	def scrape
		html = Nokogiri::HTML(open("#{@url}/ladder/leagues","User-Agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:2.0) Gecko/20100101 Firefox/4.0"))

		@league = scrape_league(html)
		@points = scrape_points(html)
		@name = scrape_name(html)

		true
	end

	def scrape_league(html)
		league = nil

		html.css("#profile-menu li a").each do |l|
			if l.text.include? "1v1"
				league = l
				break
			end
		end

		leaguename = league.text.strip.gsub(/\dv\d /, "").gsub(/ Rank.+/, "").downcase unless league.nil?
		leaguename ||= SC2League::LEAGUES.last

		SC2League.new(leaguename)
	end

	def scrape_points(html)
		td = html.css("#current-rank td")[3]

		if td.nil?
			0
		else
			Integer(td.text)
		end
	end

	def scrape_name(html)
		html.css("#profile-header h2 a").first.text
	end

	def initialize(profileurl)
		@url = profileurl

		self.scrape
	end

	def url; @url; end
	def url=(value)
		@url = value
	end

	def league; @league; end
	def points; @points; end
	def name; @name; end

	def to_s
		"#{@name} (#{@league}, #{@points} pts)"
	end

	def ==(o)
		if o.is_a? SC2Stats
			@url == o.url
		else
			false
		end
	end
end