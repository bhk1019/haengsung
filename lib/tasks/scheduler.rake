desc "This task is called by the Heroku scheduler add-on"
task :update_all_planets => :environment do
  puts "Updating all planets..."
  planets_controller_obj = PlanetsController.new
  planets_controller_obj.index
  puts "done."
end