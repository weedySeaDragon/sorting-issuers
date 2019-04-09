#!/usr/bin/ruby


#--------------------------
#
# @module SeedUtils
#
# @desc Responsibility: Common methods that help create data
#
#
# @author Ashley Engelund (ashley.engelund@gmail.com  weedySeaDragon @ github)
# @date   2019-04-09
#
# @file seed_utils.rb
#
#--------------------------


module SeedUtils


  # create a 1 or 2 letter designator
  def self.random_designator(max_length = 2)

    [*('A'..'Z')].sample(Random.rand(1..max_length)).join
  end

end
