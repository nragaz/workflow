require File.expand_path("../lib/workflow/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "workflow"
  s.version     = Workflow::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Nick Ragaz"]
  s.email       = ["nick.ragaz@gmail.com"]
  s.homepage    = "http://github.com/nragaz/workflow"
  s.summary     = "State machine for Active Record"
  s.description = "A replacement for acts_as_state_machine"

  s.required_rubygems_version = ">= 1.3.6"
  s.rubyforge_project         = "workflow"
  
  # s.add_dependency "activerecord", "~> 3"
  
  s.files        = Dir["{lib}/**/*.rb", "LICENSE", "*.md"]
  s.require_path = 'lib'
end