$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "the245plans_freee/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "the245plans_freee"
  s.version     = The245plansFreee::VERSION
  s.authors     = ["Hironobu Nishikokura"]
  s.email       = ["nishiko@mindia.jp"]
  s.homepage    = "https://github.com/pandeiro245/245plans-freee"
  s.summary     = "this is for 245plans to integrate with freee"
  s.description = "this is for 245plans to integrate with freee"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.2"

  s.add_dependency 'oauth2'
  s.add_dependency 'faraday'
  s.add_dependency 'faraday_middleware'
  s.add_dependency 'httpauth'
end
