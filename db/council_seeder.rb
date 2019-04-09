#!/usr/bin/ruby

require File.join(__dir__,  'seed_utils')

#--------------------------
#
# @class 
#
# @desc Responsibility: Seed the db with Councils
#
#
# @author Ashley Engelund (ashley.engelund@gmail.com  weedySeaDragon @ github)
# @date   2019-04-09
#
# @file LodgeSeeder
#
#--------------------------


class CouncilSeeder

  def self.make_new_one

    new_one = Council.create( designator: SeedUtils.random_designator,
                           number:     Random.rand(1..1000))

    new_one
  end


end
