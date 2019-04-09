#!/usr/bin/ruby

require 'ffaker'
require File.join(__dir__, 'lists_of_things')
require File.join(__dir__, 'seed_utils')


#--------------------------
#
# @class 
#
# @desc Responsibility: Seed the db with Chapters
#
#
# @author Ashley Engelund (ashley.engelund@gmail.com  weedySeaDragon @ github)
# @date   2019-04-09
#
# @file chapter_seeder
#
#--------------------------


class ChapterSeeder

  def self.make_new_one(lodges = Lodge.all)

    # must have at least 1 Lodge
    return unless lodges.size > 0

    name    = ListsOfThings::ANIMALS.sample

    new_one = Chapter.create(name:       name,
                             designator: SeedUtils.random_designator,
                             number:     Random.rand(1..1000),
                             lodge:      lodges.sample)
    new_one
  end

end
