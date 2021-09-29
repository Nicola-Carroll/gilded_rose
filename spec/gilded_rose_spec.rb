require './lib/gilded_rose'
require './lib/item'

describe GildedRose do
  let(:item) { Item.new('foo', 1, 0) }
  let(:items) { [item] }
  let(:gilded_rose) { described_class.new(items) }

  describe '#update_quality' do
    it 'does not change the name' do
      gilded_rose.update_quality
      expect(items[0].name).to eq 'foo'
    end

    it 'descreases an item\'s sell-in by one' do
      gilded_rose.update_quality
      expect(items[0].sell_in).to eq 0
    end

    it 'does not decrease an item\'s quality to below zero' do
      gilded_rose.update_quality
      expect(items[0].quality).to eq 0
    end

    context 'the sell-in is above zero' do
      it 'descreases a generic item\'s quality by one' do
      end
    end
  end
end
