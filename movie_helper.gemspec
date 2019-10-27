
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "movie_helper/version"

Gem::Specification.new do |spec|
  spec.name          = "movie_helper"
  spec.version       = MovieHelper::VERSION
  spec.authors       = ["dlyons8"]
  spec.email         = ["dlyons8@binghamton.edu"]

  spec.summary       = %q{Scrapes data off of website to help you find a movie to watch.}
  spec.description   = %q{This application scrapes data off of the website, https://agoodmovietowatch.com/, and uses it to feed a CLI app that helps you to find a movie to watch.}
  spec.homepage      = "https://github.com/dlyons8/movie_helper"
  spec.license       = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "nokogiri", ">= 1.10.4"
  spec.add_development_dependency "pry"
end
