require 'rails_helper'

# We use the Lodge class, which includes IssuableEntity to test the module

RSpec.describe 'IssuableEntity' do

  let(:lodge_1) { Lodge.new(name: 'lodge1', nickname: 'lodge-ones', designator: 'AX', number: 100) }
  let(:lodge_2) { Lodge.new(name: 'lodge2', nickname: 'lodge-twos', designator: 'BF', number: 200) }
  let(:lodge_3) { Lodge.new(name: 'lodge2', nickname: 'lodge-twos-bgs', designator: 'BG', number: 201) }

  let(:chapter_1) { Chapter.new(name: 'chapter1', lodge: lodge_1, designator: 'CA', number: 501) }
  let(:chapter_12) { Chapter.new(name: 'chapter12', lodge: lodge_1, designator: 'BB', number: 502) }
  let(:chapter_2) { Chapter.new(name: 'chapter2', lodge: lodge_1, designator: 'CC', number: 502) }

  let(:council_1) { Council.new(designator: 'QQ', number: 1) }
  let(:council_2) { Council.new(designator: 'QA', number: 2) }

  let(:all_issuables) { [chapter_1, chapter_12, chapter_2, council_1, council_2, lodge_1, lodge_2, lodge_3] }

  describe 'issuable_entities_sort' do

    describe 'first it compares the classes using :issuable_classes_sort_order' do

      it 'is -1 if entity1.class comes before entity2.class (entity1 should come before entity2)' do
        expect(IssuableEntity::ISSUABLE_ENTITIES_SORT.call(council_1, lodge_1)).to eq(-1)
      end

      it 'is 1 if entity1.class comes after entity2.class (entity1 should come after entity2)' do
        expect(IssuableEntity::ISSUABLE_ENTITIES_SORT.call(lodge_1, council_1)).to eq(1)
      end

      describe 'compare the issuable_sort_strings if entity1.class is the same as entity2.class' do

        it 'is -1 if entity1.issuable_sort_string < entity2.issuable_sort_string (entity1.issuable_sort_string comes before entity2.issuable_sort_string)' do
          expect(IssuableEntity::ISSUABLE_ENTITIES_SORT.call(lodge_1, lodge_2)).to eq(-1)
        end

        it 'is 1 if entity1.issuable_sort_string > entity2.issuable_sort_string (entity1.issuable_sort_string comes after entity2.issuable_sort_string)' do
          expect(IssuableEntity::ISSUABLE_ENTITIES_SORT.call(lodge_2, lodge_1)).to eq(1)
        end

        it 'is 0 if entity1.issuable_sort_string is the same as entity2.issuable_sort_string' do
          expect(IssuableEntity::ISSUABLE_ENTITIES_SORT.call(lodge_1, lodge_1)).to eq(0)
        end
      end

    end
  end

  describe 'issuable_sort_string' do

    describe 'starts with the name only if the object responds to :name' do

      it 'does not respond to :name' do
        allow(lodge_1).to receive(:respond_to?).with(:name).and_return(false)
        expect(lodge_1.issuable_sort_string).to eq 'AX 100'
      end

      it 'does respond to :name' do
        expect(lodge_1.issuable_sort_string).to eq 'lodge1AX 100'
      end
    end

    describe 'classes can redefine this method to return a different string used in sorting' do

      it 'sort order is correct' do
        # Lodges will be sorted by name, then nickname
        Lodge.define_method(:issuable_sort_string) { "#{name} #{nickname}" }

        # Councils will be sorted by number, then designator
        Council.define_method(:issuable_sort_string) { "#{number} #{designator}" }

        expect(all_issuables.sort(&IssuableEntity::ISSUABLE_ENTITIES_SORT)).to eq([council_1,
                                                                                   council_2,
                                                                                   lodge_1,
                                                                                   lodge_2,
                                                                                   lodge_3,
                                                                                   chapter_1,
                                                                                   chapter_12,
                                                                                   chapter_2])
        Lodge.remove_method(:issuable_sort_string)
        Council.remove_method(:issuable_sort_string)
      end
    end

  end

  it 'sort using the issuable_entities_sort is sorted correctly' do
    sorted_entities = all_issuables.sort(&IssuableEntity::ISSUABLE_ENTITIES_SORT)
    expect(sorted_entities).to eq([council_2,
                                   council_1,
                                   lodge_1,
                                   lodge_2,
                                   lodge_3,
                                   chapter_1,
                                   chapter_12,
                                   chapter_2
                                  ])
  end
end
