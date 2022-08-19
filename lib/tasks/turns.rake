namespace :turns do
  desc 'Assign turns'
  task hourly: :environment do
    puts "task assign turns #{DateTime.now}"
    Turns::SelectTurns.new.run
  end
end
