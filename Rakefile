desc "start server using rackup ..."
task :default do
  sh "rackup"
end

require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new do |task|
  task.rspec_opts = ["-c", "-f progress"] 
  task.pattern    = 'spec/**/*_spec.rb'
end
