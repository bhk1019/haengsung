desc "This task is called by the Heroku scheduler add-on"
task :update_all_planets => :environment do
  puts "Updating all planets..."
  PlanetsController.index
  puts "done."
end