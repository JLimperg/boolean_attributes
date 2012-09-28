Gem::Specification.new do |s|
  s.name        = 'boolean_attributes'
  s.version     = '1.0.1'

  s.summary     = "attr_accessor etc. for boolean attributes"
  s.description = <<-END
                  This gem can be used to easily add boolean attributes to
                  classes, using essentially the same syntax as for any
                  other attributes. This ensures coherent handling of boolean
                  attributes throughout a project and makes for nicer code.
                  END
  s.license     = 'MIT'

  s.authors     = ["Jannis Limperg"]
  s.email       = 'jannis.limperg@arcor.de'
  s.homepage    = 'http://rubygems.org/gems/boolean_attributes'

  s.files       = Dir["lib/**/*.rb"]

  s.add_development_dependency 'rspec'      , '~> 2.11'
  s.add_development_dependency 'rake'       , '~> 0.9'
  s.add_development_dependency 'yard'       , '~> 0.8'
  s.add_development_dependency 'redcarpet'  , '~> 2.1'
end
