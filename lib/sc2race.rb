class SC2Race
  
  # --------------------------------------------------------------------------
  #
  # Accessor and constants
  #
  # --------------------------------------------------------------------------
  
  attr_reader :race
  RACES = ["terran", "zerg", "protoss", "random"]
  

  # --------------------------------------------------------------------------
  #
  # Constructor method
  #
  # --------------------------------------------------------------------------
  
  def initialize(race = 'terran', path = '/images/races/')
    @race = RACES.include?(race) ? race : 'terran'
    @path = path
  end
  
  
  # --------------------------------------------------------------------------
  #
  # Public methods
  #
  # --------------------------------------------------------------------------

  def to_s
    "#{@race}"
  end
  
  
  def to_style
    case @race
      when 'terran' then image_x = '-5px'; image_y = '-3px'
      when 'zerg' then image_x = '-5px'; image_y = '-60px'
      when 'protoss' then image_x = '-5px'; image_y = '-115px'
      when 'random' then image_x = '-5px'; image_y = '-168px'
      else image_x = '-5px'; image_y = '-3px'
    end
    
    "background: url('#{@path}race-symbols.png') #{image_x} #{image_y} no-repeat; width: 25px; height: 25px;"
  end
end