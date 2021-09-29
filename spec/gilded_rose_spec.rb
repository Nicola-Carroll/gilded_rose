require './lib/gilded_rose'
require './lib/item'

describe GildedRose do
  let(:foo) { Item.new('foo', 1, 0) }
  let(:general_item) { Item.new('general', 5, 10) }
  let(:aged_brie) { Item.new('Aged Brie', 3, 4) }
  let(:sulfuras) { Item.new('Sulfuras, Hand of Ragnaros', 0, 80) }
  let(:backstage_pass) do
    Item.new('Backstage passes to a TAFKAL80ETC concert', 14, 21)
  end
  let(:items) { [foo, general_item, aged_brie, sulfuras, backstage_pass] }
  let(:gilded_rose) { described_class.new(items) }

  describe '#update_quality' do
    it 'does not change the name' do
      gilded_rose.update_quality
      expect(items[0].name).to eq 'foo'
    end

    it 'does not decrease an item\'s quality to below zero' do
      gilded_rose.update_quality
      expect(items[0].quality).to eq 0
    end

    it 'has no impact on the number of items' do
      number_of_items = items.count
      gilded_rose.update_quality
      expect(items.count).to eq number_of_items
    end

    context 'generic item' do
      it 'descreases a generic item\'s sell-in by one' do
        expect { gilded_rose.update_quality }.to change { general_item.sell_in }
          .by(-1)
      end

      it 'descreases a generic item\'s quality by one when sell-by is not reached' do
        expect { gilded_rose.update_quality }.to change { general_item.quality }
          .by(-1)
      end

      it 'the quality reduces twice as fast after sell by date' do
        5.times { gilded_rose.update_quality }
        expect { gilded_rose.update_quality }.to change { general_item.quality }
          .by(-2)
      end
    end

    context 'aged brie' do
    end

    context 'sulfuras' do
    end

    context 'backstaged passes' do
    end
  end
end
