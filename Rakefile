require 'rake'
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each {|file| require file }

desc 'Default: setup application'
task :default => :setup

desc "Setup the application"
task :setup => :install_settings do

end

desc "Create settings file from example"
  unless File.exists? File.join("settings.yml")
    puts "Where's your settings.yml, dude?"
    if File.exist? File.join("settings.yml.example")
      puts "(elided)... so I'll make a copy of it for you."

      cp File.join("settings.yml.example"),
        File.join("settings.yml")

        abort "(elided)...rerun the last command."
    else
      abort "(elided)...There's no config/settings.yml.example..."
    end
  end
end

desc "Import Memori bookmarks and export it to Del.icio.us"
task :run do
  runner = Memoritious::Runner.new
  runner.local = false
  puts "Running import/export routing. It may take some time to complete, don't worry, dude!"
  runner.run()
  puts "Yeeehaw! Import/Export of your bookmarks was finished. Go to Del.icio.us and check for results!"
end

desc "Import memori bookmarks"
task :import do
  runner = Memoritious::Runner.new
  runner.local = false
  bookmarks = runner.get_links()
  
  puts "Imported #{bookmarks.size} bookmarks from memori.ru"
end

desc "Import memori bookmarks, use for debug purposes"
task :import_local do
  runner = Memoritious::Runner.new
  runner.local = true
  bookmarks = runner.get_links()
  
  puts "Imported #{bookmarks.size} bookmarks from memori.ru"
end