class SC2League
  
  # --------------------------------------------------------------------------
  #
  # Accessor and constants
  #
  # --------------------------------------------------------------------------
  
  attr_reader :league_name, :league_type, :rank
  LEAGUES = ["no league", "bronze", "silver", "gold", "platinum", "diamond", "master", "grandmaster"]
  
  
  # --------------------------------------------------------------------------
  #
  # Constructor method
  #
  # --------------------------------------------------------------------------
  
  def initialize(league_name = 'bronze', league_type = '1v1', rank = 0, path = '/images/leagues/')
    @league_name = LEAGUES.include?(league_name) ? league_name : 'bronze'
    @league_type = league_type
    @rank = rank
    @path = path
  end


  # --------------------------------------------------------------------------
  #
  # Public methods
  #
  # --------------------------------------------------------------------------

  def to_s
    "#{@league_name} #{@league_type} rank #{@rank}"
  end
  
  def to_style(size = :medium)
    case size
      when :small then image_x = '-145px'; image_size = '28px'
      when :medium then image_x = '-100px'; image_size = '45px'
      when :big then image_x = '0px'; image_size = '100px'
      else image_x = '-100px'; image_size = '45px'
    end
    
    case @rank
      when 1..8 then image_y = '-150px'
      when 9..25 then image_y = '-100px'
      when 26..50 then image_y = '-50px'
      when 51..200 then image_y = '0px'
      else image_y = '0px'
    end
    
    "background: url('#{@path}#{@league_name.gsub(/\s/, '')}.png') #{image_x} #{image_y} no-repeat; width: #{image_size}; height: #{image_size};"
  end
  
  def as_json(opts={})
    {
      :league_name => @league_name,
      :league_type => @league_type,
      :rank => @rank,
    }
  end
end