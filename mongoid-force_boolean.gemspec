$: << File.expand_path('../lib', __FILE__)
require 'mongoid/version'

Gem::Specification.new do |gem|
  gem.name          = 'mongoid-force_boolean'
  gem.version       = Mongoid::ForceBoolean::VERSION
  gem.authors       = 'Tumayun'
  gem.email         = 'tumayun.2010@gmail.com'
  gem.homepage      = 'https://github.com/tumayun/mongoid-force_boolean'
  gem.summary       = 'Mongoid document boolean type field can only be true or false.'
  gem.description   = 'Mongoid document boolean type field can only be true or false.'

  gem.files         = `git ls-files`.split("\n")
  gem.require_path  = 'lib'

  gem.add_dependency 'activesupport', '>= 3.0'
  gem.add_dependency 'mongoid', '>= 3.1.4'
end
