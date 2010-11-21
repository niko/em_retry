# encoding: utf-8

$:.unshift File.expand_path('../lib', __FILE__)
require 'em_retry/version'

Gem::Specification.new do |s|
  s.name         = "em_retry"
  s.version      = EmRetry::VERSION
  s.authors      = ["Niko Dittmann"]
  s.email        = "mail+git@niko-dittmann.com"
  s.homepage     = "http://github.com/niko/em_retry"
  s.summary      = "A retry-method for Eventmachine and a convenience wrapper."
  s.description  = s.description
  
  s.add_dependency "eventmachine"
  s.add_development_dependency 'rspec'
  s.files        = Dir['lib/**/*.rb']
  s.test_files   = Dir['spec/**/*_spec.rb']
  
  s.platform     = Gem::Platform::RUBY
  s.require_path = 'lib'
  s.rubyforge_project = '[none]'
end
