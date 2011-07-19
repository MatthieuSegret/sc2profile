class SC2PortraitStyle

  # --------------------------------------------------------------------------
  #
  # Accessor
  #
  # --------------------------------------------------------------------------

  attr_reader :image_index, :image_x, :image_y


  # --------------------------------------------------------------------------
  #
  # Constructor method
  #
  # --------------------------------------------------------------------------

  def initialize(image_index = 0, image_x = 0, image_y = 0, path = '/images/portraits/')
    @image_index = image_index
    @image_x = image_x
    @image_y = image_y
    @path = path
  end


  # --------------------------------------------------------------------------
  #
  # Public methods
  #
  # --------------------------------------------------------------------------

  def to_s
    to_style
  end

  def to_style(size = :medium)
    case size
      when :medium then image_x = @image_x / 2; image_y = @image_y / 2; image_size = 45
      when :big then image_x = @image_x; image_y = @image_y; image_size = 90
      else image_x = @image_x / 2; image_y = @image_y / 2; image_size = 45
    end
    
    "background: url('#{@path}#{@image_index}-#{image_size}.jpg') #{image_x}px #{image_y}px no-repeat; width: #{image_size}px; height: #{image_size}px;"
  end

  def as_json(opts={})
    {
      :image_index => @image_index.to_i,
      :image_x => @image_x,
      :image_y => @image_y
    }
  end

end