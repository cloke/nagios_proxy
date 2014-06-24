namespace :proxy do
  desc "TODO"
  task load_settings: :environment do
    MessagesController.new.execute_commands
  end

end
