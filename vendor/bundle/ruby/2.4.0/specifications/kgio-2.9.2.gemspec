# -*- encoding: utf-8 -*-
# stub: kgio 2.9.2 ruby lib
# stub: ext/kgio/extconf.rb

Gem::Specification.new do |s|
  s.name = "kgio".freeze
  s.version = "2.9.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["kgio hackers".freeze]
  s.date = "2014-02-15"
  s.description = "kgio provides non-blocking I/O methods for Ruby without raising\nexceptions on EAGAIN and EINPROGRESS.  It is intended for use with the\nUnicorn and Rainbows! Rack servers, but may be used by other\napplications (that run on Unix-like platforms).".freeze
  s.email = "kgio@librelist.org".freeze
  s.extensions = ["ext/kgio/extconf.rb".freeze]
  s.extra_rdoc_files = ["LICENSE".freeze, "README".freeze, "TODO".freeze, "NEWS".freeze, "LATEST".freeze, "ChangeLog".freeze, "ISSUES".freeze, "HACKING".freeze, "lib/kgio.rb".freeze, "ext/kgio/accept.c".freeze, "ext/kgio/autopush.c".freeze, "ext/kgio/connect.c".freeze, "ext/kgio/kgio_ext.c".freeze, "ext/kgio/poll.c".freeze, "ext/kgio/wait.c".freeze, "ext/kgio/tryopen.c".freeze]
  s.files = ["ChangeLog".freeze, "HACKING".freeze, "ISSUES".freeze, "LATEST".freeze, "LICENSE".freeze, "NEWS".freeze, "README".freeze, "TODO".freeze, "ext/kgio/accept.c".freeze, "ext/kgio/autopush.c".freeze, "ext/kgio/connect.c".freeze, "ext/kgio/extconf.rb".freeze, "ext/kgio/kgio_ext.c".freeze, "ext/kgio/poll.c".freeze, "ext/kgio/tryopen.c".freeze, "ext/kgio/wait.c".freeze, "lib/kgio.rb".freeze]
  s.homepage = "http://bogomips.org/kgio/".freeze
  s.rdoc_options = ["-t".freeze, "kgio - kinder, gentler I/O for Ruby".freeze, "-W".freeze, "http://bogomips.org/kgio.git/tree/%s".freeze]
  s.rubyforge_project = "rainbows".freeze
  s.rubygems_version = "2.6.8".freeze
  s.summary = "kinder, gentler I/O for Ruby".freeze

  s.installed_by_version = "2.6.8" if s.respond_to? :installed_by_version
end
