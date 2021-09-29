class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def item_details()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
