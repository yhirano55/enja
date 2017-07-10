$:.push File.expand_path("../lib", __FILE__)
require "enja/version"

Gem::Specification.new do |s|
  s.name        = "enja"
  s.version     = Enja::VERSION
  s.authors     = ["Yoshiyuki Hirano"]
  s.email       = ["yhirano@me.com"]
  s.summary     = %q{Easily role definition for Rails}
  s.description = s.summary
  s.homepage    = "https://github.com/yhirano55/enja"
  s.license     = "MIT"

  s.required_ruby_version = ">= 2.2.0"

  s.add_dependency "enumerize"

  s.add_development_dependency "bundler", "~> 1.15"

  s.files         = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files    = Dir["spec/**/*"]
  s.require_paths = ["lib"]
end
