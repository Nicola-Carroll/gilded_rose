class GildedRose
  def initialize(items)
    @items = items
  end

  def decrease_sell_in(item)
    item.sell_in -= 1 unless item.name == 'Sulfuras, Hand of Ragnaros'
  end

  def item_quality_increases?(item)
    (item.name == 'Aged Brie' && item.quality < 50) ||
      (
        item.name == 'Backstage passes to a TAFKAL80ETC concert' &&
          item.quality < 50 && item.sell_in > 0
      )
  end

  def item_quality_static?(item)
    (
      item.quality == 0 && item.name != 'Aged Brie' &&
        item.name != 'Backstage passes to a TAFKAL80ETC concert'
    ) || (item.name == 'Sulfuras, Hand of Ragnaros') ||
      (item.quality == 50 && item.name == 'Aged Brie') ||
      (
        item.quality == 50 &&
          item.name == 'Backstage passes to a TAFKAL80ETC concert' &&
          item.sell_in > 0
      )
  end

  def decrease_item_quality(item)
    if item.name == 'Backstage passes to a TAFKAL80ETC concert'
      item.quality = 0
    elsif item.sell_in > 0
      item.quality -= 1
    else
      item.quality -= 2
    end
  end

  def increase_item_quality(item)
    if item.name == 'Aged Brie'
      item.quality += 1
    elsif item.name == 'Backstage passes to a TAFKAL80ETC concert' &&
          10 < item.sell_in
      item.quality += 1
    elsif item.name == 'Backstage passes to a TAFKAL80ETC concert' &&
          item.sell_in.between?(6, 10)
      item.quality += 2
    else
      item.quality += 3
    end
  end

  def update_item_quality(item)
    decrease_sell_in(item)
    if item_quality_static?(item)
      return
    elsif item_quality_increases?(item)
      increase_item_quality(item)
    else
      decrease_item_quality(item)
    end
  end

  def update_quality()
    @items.each { |item| update_item_quality(item) }
  end
end
# def update_quality()
#   @items.each do |item|
#     if item.name != 'Aged Brie' &&
#          item.name != 'Backstage passes to a TAFKAL80ETC concert'
#       if item.quality > 0
#         if item.name != 'Sulfuras, Hand of Ragnaros'
#           item.quality = item.quality - 1
#         end
#       end
#     else
#       if item.quality < 50
#         item.quality = item.quality + 1
#         if item.name == 'Backstage passes to a TAFKAL80ETC concert'
#           if item.sell_in < 11
#             item.quality = item.quality + 1 if item.quality < 50
#           end
#           if item.sell_in < 6
#             item.quality = item.quality + 1 if item.quality < 50
#           end
#         end
#       end
#     end
#     if item.name != 'Sulfuras, Hand of Ragnaros'
#       item.sell_in = item.sell_in - 1
#     end
#     if item.sell_in < 0
#       if item.name != 'Aged Brie'
#         if item.name != 'Backstage passes to a TAFKAL80ETC concert'
#           if item.quality > 0
#             if item.name != 'Sulfuras, Hand of Ragnaros'
#               item.quality = item.quality - 1
#             end
#           end
#         else
#           item.quality = item.quality - item.quality
#         end
#       else
#         item.quality = item.quality + 1 if item.quality < 50
#       end
#     end
#   end
# end
