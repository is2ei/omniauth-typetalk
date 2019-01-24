lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'omniauth-typetalk/version'

Gem::Specification.new do |spec|
  spec.name          = 'omniauth-typetalk'
  spec.version       = OmniAuth::Typetalk::VERSION
  spec.authors       = ['Issei Horie']
  spec.email         = ['is2ei.horie@gmail.com']

  spec.summary       = 'OmniAuth strategy for Typetalk.'
  spec.description   = 'OmniAuth strategy for Typetalk, chat app by Nulab'
  spec.homepage      = 'https://github.com/is2ei/omniauth-typetalk'
  spec.license       = 'MIT'

  spec.files         = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`
      .split("\x0")
      .reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_dependency 'omniauth', '~> 1.5'
  spec.add_dependency 'omniauth-oauth2', '>= 1.4.0', '< 2.0'
  spec.add_development_dependency 'rack-test', '0.6.3'
  spec.add_development_dependency 'simplecov', '0.16.1'
  spec.add_development_dependency 'webmock', '3.5.1'
end
