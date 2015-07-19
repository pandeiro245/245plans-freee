$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "the245plans_freee/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "the245plans_freee"
  s.version     = The245plansFreee::VERSION
  s.authors     = ["Hironobu Nishikokura"]
  s.email       = ["nishiko@mindia.jp"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of The245plansFreee."
  s.description = "TODO: Description of The245plansFreee."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.3"

  s.add_development_dependency "sqlite3"
end
