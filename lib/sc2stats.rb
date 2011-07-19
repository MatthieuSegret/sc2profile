require "rubygems"
require "bundler/setup"

require "nokogiri"
require 'open-uri'
require 'sc2league'
require 'sc2portrait_style'
require 'sc2race'

class SC2Stats
  
  # --------------------------------------------------------------------------
  #
  # Accessor
  #
  # --------------------------------------------------------------------------
  
  attr_reader :name, :race, :points, :league, :portrait_style
  attr_accessor :url, :options
  
  
  # --------------------------------------------------------------------------
  #
  # Constructor method
  #
  # --------------------------------------------------------------------------
  
  def initialize(profileurl, options=[:name, :race, :points, :league, :portrait_style])
    @url = profileurl
    @options = options
    self.scrape @options
  end
  
  
  # --------------------------------------------------------------------------
  #
  # Public methods
  #
  # --------------------------------------------------------------------------
  
  def to_s
    "#{@name} (#{@league}, #{@race}, #{@points} pts)"
  end

  def ==(o)
    if o.is_a? SC2Stats
      @url == o.url
    else
      false
    end
  end
  
  def scrape(options)
    @url.chop! if @url.last == '/'
    @url.gsub!(/(.+\/sc2\/)(\w{2})(\/profile\/.+)/, '\1en\3')
    html = Nokogiri::HTML(open("#{@url}/ladder/leagues"))

    options.each do |option|
      instance_variable_set("@#{option.to_s}".to_sym, self.send("scrape_#{option.to_s}", html))
    end
  end
  
  
  # --------------------------------------------------------------------------
  #
  # Protected methods
  #
  # --------------------------------------------------------------------------
  
  protected
  
  def scrape_name(html)
    html.css("#profile-header h2 a").first.text
  end
  
  def scrape_portrait_style(html)
    raw_portrait_style = html.css("#portrait span").attr('style').to_s
    return SC2PortraitStyle.new if raw_portrait_style.blank?
    style_split = raw_portrait_style.split
    image_index = /.+\/(\d)-90.jpg.+/.match(style_split[1])[1]
    image_x = style_split[2]
    image_y = style_split[3]
    SC2PortraitStyle.new(image_index, image_x.split('px')[0].to_i, image_y.split('px')[0].to_i)
  end
  
  def scrape_race(html)
    td = html.css("#current-rank td")[current_rank_index_start(html) + 2]
    return SC2Race.new if td.blank?
    a = td.css("a")
    return SC2Race.new if a.blank?
    class_race = a.attr('class').to_s
    return SC2Race.new if class_race.blank?
    race = class_race.split('-')[1]
    SC2Race.new(race)
  end
  
  def scrape_points(html)
    td = html.css("#current-rank td")[current_rank_index_start(html) + 3]
    td.present? ? td.text.to_i : 0
  end

  def scrape_league(html, league_type='1v1')
    league_text = nil
    
    html.css("#profile-menu li a").each do |l|
      if l.text.include? league_type
        league_text = l.text
        break
      end
    end

    if league_text.present?
      league_split = league_text.downcase.split
      league_name = league_split[1]
      rank = league_split[3].to_i
    else
      return SC2League.new
    end

    SC2League.new(league_name, league_type, rank)
  end
  
  def current_rank_index_start(html)
    tds = html.css("#current-rank td")
    return 0 if tds.blank?
    tds[0].attr('class').to_s.include?('banner') ? 1 : 0
  end
end