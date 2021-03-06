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
      it 'decreases a generic item\'s sell-in by one' do
        expect { gilded_rose.update_quality }.to change { general_item.sell_in }
          .by(-1)
      end

      it 'decreases a generic item\'s quality by one when sell-by is not reached' do
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
      it 'decreases bries\'s sell-in by one' do
        expect { gilded_rose.update_quality }.to change { aged_brie.sell_in }
          .by(-1)
      end

      it 'increases bries quality' do
        expect { gilded_rose.update_quality }.to change { aged_brie.quality }
          .by(1)
      end

      it 'has a max quality of 50' do
        50.times { gilded_rose.update_quality }
        expect { gilded_rose.update_quality }.to change { aged_brie.quality }
          .by(0)
      end
    end

    context 'sulfuras' do
      it 'unchages sulfuras sell_in' do
        expect { gilded_rose.update_quality }.to change { sulfuras.sell_in }.by(
          0
        )
      end

      it 'unchages sulfuras quality' do
        expect { gilded_rose.update_quality }.to change { sulfuras.quality }.by(
          0
        )
      end
    end

    context 'backstaged passes' do
      it 'decreases a backstage pass sell-in by one' do
        expect { gilded_rose.update_quality }.to change {
          backstage_pass.sell_in
        }.by(-1)
      end

      it 'increases quality by one when sell_in>10' do
        expect { gilded_rose.update_quality }.to change {
          backstage_pass.quality
        }.by(1)
      end

      it 'increases quality by two when 10>=sell_in>5' do
        4.times { gilded_rose.update_quality }
        expect { gilded_rose.update_quality }.to change {
          backstage_pass.quality
        }.by(2)
      end

      it 'increases quality by three when 5>=sell_in>0' do
        9.times { gilded_rose.update_quality }
        expect { gilded_rose.update_quality }.to change {
          backstage_pass.quality
        }.by(3)
      end

      it 'its value drops to zero after the concert' do
        15.times { gilded_rose.update_quality }
        expect(backstage_pass.quality).to eq 0
      end
    end
  end
end
