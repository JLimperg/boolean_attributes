Gem::Specification.new do |s|
  s.name        = 'boolean_attributes'
  s.version     = '1.0.1'

  s.summary     = "attr_accessor etc. for boolean attributes"
  s.description = <<-END
                  Add boolean attributes to your classes with a variant of the
                  familiar attr_* syntax. This ensures coherent treatment of
                  boolean attributes throught the project and makes your code
                  more DRY.
                  END
  s.license     = 'MIT'

  s.authors     = ["Jannis Limperg"]
  s.email       = 'jannis.limperg@arcor.de'
  s.homepage    = 'http://rubygems.org/gems/boolean_attributes'

  s.files       = Dir["lib/**/*"] +
                  Dir["spec/**/*"] +
                  %w{Rakefile LICENSE README.md NEWS .yardopts Gemfile
                     boolean_attributes.gemspec}

  s.add_development_dependency 'rspec'      , '~> 2.11'
  s.add_development_dependency 'rake'       , '~> 0.9'
  s.add_development_dependency 'yard'       , '~> 0.8'
  s.add_development_dependency 'redcarpet'  , '~> 2.1'
end
