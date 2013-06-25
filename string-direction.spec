Gem::Specification.new do |s|
   s.name = 'string-direction'
   s.version = '0.0.1'
   s.summary = 'Automatic detection of text direction (ltr, rtl or bidi) for strings'
   s.description = 'https://github.com/laMarciana/string-direction/'
   s.license = 'GPL3'
   s.homepage = 'https://github.com/laMarciana/string-direction/'
   s.authors = ['Marc Busqué']
   s.email = 'marc@lamarciana.com'
   s.files = `git ls-files`.split("\n")

   s.add_runtime_dependency "yard", "~>0.8"
   s.add_runtime_dependency "redcarpet", "~>2.2"

   s.add_development_dependency "rspec", "~>2.13"
end
