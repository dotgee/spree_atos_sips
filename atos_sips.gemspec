# encoding: UTF-8
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_atos_sips'
  s.version     = '1.0'
  s.summary     = 'Spree Extenstion for Atos'
  s.description = 'Payment Method for Atos Worldline for Spree'
  s.required_ruby_version = '>= 1.8.7'

  s.authors     = ['Johann W']
  s.email       = 'johann@dotgee.fr'
  s.homepage    = 'https://github.com/Johann-dotgee/spree_atos_sips'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency('spree_core', '>=1.0.0')
  s.add_development_dependency 'rspec-rails'

end