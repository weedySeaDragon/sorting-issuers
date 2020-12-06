require 'rails_helper'

RSpec.describe Lodge do

  let(:lodge_1) { Lodge.new(name: 'lodge1', nickname: 'lodge-ones', designator: 'AX', number: 100) }
  let(:lodge_2) { Lodge.new(name: 'lodge2', nickname: 'lodge-twos bf 200', designator: 'BF', number: 200) }
  let(:lodge_2_201) { Lodge.new(name: 'lodge2', nickname: 'lodge-twos bf 201', designator: 'BG', number: 201) }
  let(:lodge_2_aa) { Lodge.new(name: 'lodge2', nickname: 'lodge-twos AA', designator: 'AA', number: 201) }
  let(:lodge_0) { Lodge.new(name: 'lodge0', nickname: 'lodge-zeros', designator: 'A1', number: 1) }

  let(:all_lodges) { [lodge_1, lodge_2_201, lodge_2_aa, lodge_2, lodge_0] }

  describe 'sorting' do

    it 'string used to do sorting is constructed from the lodge name, designator, and number' do
      expect(lodge_1.issuable_sort_string).to eq 'lodge1AX 100'
    end

    it 'sorts using the issuable_sort_string for each lodge' do
      all_lodges.each do |lodge|
        expect(lodge).to receive(:issuable_sort_string).at_least(1).times.and_call_original
      end

      # sort using the ISSUABLE_ENTITIES_SORT block (which happens to be a lambda)
      all_lodges.sort(&IssuableEntity::ISSUABLE_ENTITIES_SORT)
    end

    it 'sorted order is correct' do
      expect(all_lodges.sort(&IssuableEntity::ISSUABLE_ENTITIES_SORT)).to eq([lodge_0,
                                                                              lodge_1,
                                                                              lodge_2_aa,
                                                                              lodge_2,
                                                                              lodge_2_201])
    end

    it 'can define issuable_sort_string to return a different string used in sorting' do

    end

    it 'can use a different block to do the sorting' do
      sort_by_designator = lambda { |lodge_1, lodge_2| lodge_1.designator <=> lodge_2.designator }

      expect(all_lodges.sort(&sort_by_designator)).to eq([lodge_0,
                                                          lodge_2_aa,
                                                          lodge_1,
                                                          lodge_2,
                                                          lodge_2_201])
    end
  end

end
