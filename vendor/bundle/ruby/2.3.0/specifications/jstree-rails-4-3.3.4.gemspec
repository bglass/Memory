# -*- encoding: utf-8 -*-
# stub: jstree-rails-4 3.3.4 ruby lib

Gem::Specification.new do |s|
  s.name = "jstree-rails-4".freeze
  s.version = "3.3.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Kesha Antonov".freeze]
  s.date = "2017-04-10"
  s.description = "jsTree is jquery plugin, that provides interactive trees. It is absolutely free, open source and distributed under the MIT license.".freeze
  s.email = ["innokenty.longway@gmail.com".freeze]
  s.homepage = "https://github.com/kesha-antonov/jstree-rails-4".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.5.2.1".freeze
  s.summary = "Integrate jsTree javascript library with Rails asset pipeline".freeze

  s.installed_by_version = "2.5.2.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<json>.freeze, ["~> 2.0.3"])
      s.add_development_dependency(%q<thor>.freeze, ["~> 0.19"])
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.14"])
      s.add_development_dependency(%q<httpclient>.freeze, ["~> 2.8.3"])
    else
      s.add_dependency(%q<json>.freeze, ["~> 2.0.3"])
      s.add_dependency(%q<thor>.freeze, ["~> 0.19"])
      s.add_dependency(%q<bundler>.freeze, ["~> 1.14"])
      s.add_dependency(%q<httpclient>.freeze, ["~> 2.8.3"])
    end
  else
    s.add_dependency(%q<json>.freeze, ["~> 2.0.3"])
    s.add_dependency(%q<thor>.freeze, ["~> 0.19"])
    s.add_dependency(%q<bundler>.freeze, ["~> 1.14"])
    s.add_dependency(%q<httpclient>.freeze, ["~> 2.8.3"])
  end
end
