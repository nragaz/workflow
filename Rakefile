require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

desc 'Default: run unit tests.'
task :default => :test

desc 'Run unit tests'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

desc 'Generate documentation'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'nragaz-workflow'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

namespace :gem do
  desc 'Build gem'
  task :build => :cleanup do
    system "gem build nragaz-workflow.gemspec"
  end
  
  desc 'Build and install gem'
  task :install => :build do
    require 'lib/workflow/version'
    system "gem install nragaz-workflow-#{Workflow::VERSION}.gem"
  end
  
  desc 'Remove built gem(s)'
  task :cleanup do
    system 'rm nragaz-workflow-*.gem'
  end
end