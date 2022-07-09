require_relative "lib/change_base/version"

Gem::Specification.new do |spec|
  spec.name = "change_base"
  spec.version = ChangeBase::VERSION
  spec.authors = ["Brent Sanders"]
  spec.email = ["git@gmail.com"]

  spec.summary = %q{Command line util to change integer base}
  spec.description = %q{A commsnd line utility to convert integers into arbitrary bases.}

  spec.homepage = "https://github.com/pdkl95/change_base"
  spec.license = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage

  spec.cert_chain = ['certs/pdkl95.pem']
  spec.signing_key = File.expand_path("~/.ssh/gem-private_key.pem") if $0 =~ /gem\z/

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
