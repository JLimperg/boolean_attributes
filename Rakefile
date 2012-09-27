task :default => :test
task :test    => :spec

# RSpec
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = "spec/spec.rb"
end

# YARD
require 'yard'
YARD::Rake::YardocTask.new(:doc)
