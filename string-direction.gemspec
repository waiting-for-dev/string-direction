# frozen_string_literal: true

require_relative 'lib/string-direction/version'
require 'rake/file_list'

Gem::Specification.new do |s|
  s.name = 'string-direction'
  s.version = StringDirection::VERSION
  s.summary = 'Automatic detection of text direction (ltr, rtl or bidi) for strings'
  s.description = 'https://github.com/waiting-for-dev/string-direction/'
  s.license = 'GPL3'
  s.homepage = 'https://github.com/waiting-for-dev/string-direction/'
  s.authors = ['Marc Busqué']
  s.email = 'marc@lamarciana.com'
  s.files = Rake::FileList['COPYING.txt', 'lib/**/*', 'README.md'].exclude(*File.read('.gitignore').split)

  s.add_development_dependency 'bundler', '~> 2.1'
  s.add_development_dependency 'pry', '~> 0.13'
  s.add_development_dependency 'pry-byebug', '~> 3.9'
  s.add_development_dependency 'rake', '~> 13.0'
  s.add_development_dependency 'rspec', '~> 3.9'
  s.add_development_dependency 'rubocop', '~> 0.90'
  s.add_development_dependency 'rubocop-packaging', '~> 0.4'
end
