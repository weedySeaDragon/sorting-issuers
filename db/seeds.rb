seeders = %w( lodge_seeder council_seeder chapter_seeder)

seeders.each { |seed_file| require File.join(__dir__, seed_file) }


admin = User.find_or_create_by(first_name: 'Ashley',
                       last_name:  'E',
                       email:      'registrations@ashleycaroline.com') do | user |
  user.admin = true
  user.password=  'whatever'
end

admin.save

NUM_LODGES   = 11
NUM_COUNCILS = 5
NUM_CHAPTERS = 38

NUM_LODGES.times { LodgeSeeder.make_new_one }
NUM_COUNCILS.times { CouncilSeeder.make_new_one }
NUM_CHAPTERS.times { ChapterSeeder.make_new_one }
