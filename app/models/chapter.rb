class Chapter < ApplicationRecord
  belongs_to :lodge

  include IssuableEntity


  # String to use to compare 2 Chapter objects
  # This is here just to show how overriding can be used
  #
  # Silly, but Chapters are sorted using a different string
  #
  def issuable_sort_string
    "#{number}#{designator} #{name}"
  end

end
