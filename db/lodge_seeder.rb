#!/usr/bin/ruby

require 'ffaker'
require File.join(__dir__,  'lists_of_things')
require File.join(__dir__,  'seed_utils')


#--------------------------
#
# @class 
#
# @desc Responsibility: Seed the db with Lodges
#
#
# @author Ashley Engelund (ashley.engelund@gmail.com  weedySeaDragon @ github)
# @date   2019-04-09
#
# @file LodgeSeeder
#
#--------------------------


class LodgeSeeder

  def self.make_new_one

    name    = ListsOfThings::ANIMALS.sample
    new_one = Lodge.create(name:       name,
                           nickname:   name,
                           designator: SeedUtils.random_designator,
                           number:     Random.rand(1..1000))

    new_one
  end

end
