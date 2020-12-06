#!/usr/bin/ruby
# frozen_string_literal: true

#--------------------------
#
# @module IssuableEntity
#
# @desc Responsibility:  All common behavior for entities that can create or own an Issue
#
#
# @author Ashley Engelund (ashley.engelund@gmail.com  weedySeaDragon @ github)
# @date   2019-04-09
#
# @file issuable_entity.rb
#
#--------------------------
module IssuableEntity

  # how to sort all of the IssuableEntity classes: first all Councils, then all Lodges, then all Chapters
  def self.issuable_classes_sort_order
    [Council, Lodge, Chapter]
  end


  # Each class should implement this in whatever way makes sense.
  # this is used to sort IssueableEntities
  ISSUABLE_ENTITIES_SORT = lambda { |ie_1, ie_2|
    class_index_1 = issuable_classes_sort_order.index(ie_1.class)
    class_index_2 = issuable_classes_sort_order.index(ie_2.class)

    if class_index_1 < class_index_2
      -1
    elsif class_index_1 > class_index_2
      1
    else
      # the classes are the same, so use the instance issuable_sort_string to compare them
      ie_1.issuable_sort_string <=> ie_2.issuable_sort_string
    end
  }


  # String to use to compare 2 IssuableEntity objects
  # This is the default implementation.  Classes should override this as needed
  #
  # We know that every IssuableEntity has a designator and number,
  # and that only some of the have names.
  def issuable_sort_string
    name_placeholder = respond_to?(:name) ? name : ''
    "#{name_placeholder}#{designator} #{number}"
  end

end
