# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "contact_parser/version"

Gem::Specification.new do |spec|
  spec.name          = "contact_parser"
  spec.version       = ContactParser::VERSION
  spec.authors       = ["Jordan Hudgens"]
  spec.email         = ["jordan@wow.com"]

  spec.summary       = %q{Parses a basic set of names and email addresses and outputs a hash.}
  spec.description   = %q{Includes email and presence validations.}
  spec.homepage      = "https://github.com/jordanhudgens/contact_parser"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_dependency 'email_address', '~> 0.2.4'
end
