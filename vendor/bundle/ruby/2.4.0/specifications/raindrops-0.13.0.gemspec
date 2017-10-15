# -*- encoding: utf-8 -*-
# stub: raindrops 0.13.0 ruby lib
# stub: ext/raindrops/extconf.rb

Gem::Specification.new do |s|
  s.name = "raindrops".freeze
  s.version = "0.13.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["raindrops hackers".freeze]
  s.date = "2014-02-18"
  s.description = "Raindrops is a real-time stats toolkit to show statistics for Rack HTTP\nservers.  It is designed for preforking servers such as Rainbows! and\nUnicorn, but should support any Rack HTTP server under Ruby 2.0, 1.9,\n1.8 and Rubinius on platforms supporting POSIX shared memory.  It may\nalso be used as a generic scoreboard for sharing atomic counters across\nmultiple processes.".freeze
  s.email = "raindrops@librelist.org".freeze
  s.extensions = ["ext/raindrops/extconf.rb".freeze]
  s.extra_rdoc_files = ["README".freeze, "LICENSE".freeze, "NEWS".freeze, "ChangeLog".freeze, "lib/raindrops.rb".freeze, "lib/raindrops/aggregate.rb".freeze, "lib/raindrops/aggregate/last_data_recv.rb".freeze, "lib/raindrops/aggregate/pmq.rb".freeze, "lib/raindrops/last_data_recv.rb".freeze, "lib/raindrops/linux.rb".freeze, "lib/raindrops/middleware.rb".freeze, "lib/raindrops/middleware/proxy.rb".freeze, "lib/raindrops/struct.rb".freeze, "lib/raindrops/watcher.rb".freeze, "ext/raindrops/raindrops.c".freeze, "ext/raindrops/linux_inet_diag.c".freeze, "ext/raindrops/linux_tcp_info.c".freeze]
  s.files = ["ChangeLog".freeze, "LICENSE".freeze, "NEWS".freeze, "README".freeze, "ext/raindrops/extconf.rb".freeze, "ext/raindrops/linux_inet_diag.c".freeze, "ext/raindrops/linux_tcp_info.c".freeze, "ext/raindrops/raindrops.c".freeze, "lib/raindrops.rb".freeze, "lib/raindrops/aggregate.rb".freeze, "lib/raindrops/aggregate/last_data_recv.rb".freeze, "lib/raindrops/aggregate/pmq.rb".freeze, "lib/raindrops/last_data_recv.rb".freeze, "lib/raindrops/linux.rb".freeze, "lib/raindrops/middleware.rb".freeze, "lib/raindrops/middleware/proxy.rb".freeze, "lib/raindrops/struct.rb".freeze, "lib/raindrops/watcher.rb".freeze]
  s.homepage = "http://raindrops.bogomips.org/".freeze
  s.licenses = ["LGPLv2.1+".freeze]
  s.rdoc_options = ["-t".freeze, "raindrops - real-time stats for preforking Rack servers".freeze, "-W".freeze, "http://bogomips.org/raindrops.git/tree/%s".freeze]
  s.rubyforge_project = "rainbows".freeze
  s.rubygems_version = "2.6.8".freeze
  s.summary = "real-time stats for preforking Rack servers".freeze

  s.installed_by_version = "2.6.8" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<aggregate>.freeze, ["~> 0.2"])
      s.add_development_dependency(%q<io-extra>.freeze, [">= 1.2.3", "~> 1.2"])
      s.add_development_dependency(%q<posix_mq>.freeze, ["~> 2.0"])
      s.add_development_dependency(%q<rack>.freeze, ["~> 1.2"])
      s.add_development_dependency(%q<unicorn>.freeze, [">= 0.98"])
      s.add_development_dependency(%q<wrongdoc>.freeze, [">= 1.6.2", "~> 1.6.2"])
    else
      s.add_dependency(%q<aggregate>.freeze, ["~> 0.2"])
      s.add_dependency(%q<io-extra>.freeze, [">= 1.2.3", "~> 1.2"])
      s.add_dependency(%q<posix_mq>.freeze, ["~> 2.0"])
      s.add_dependency(%q<rack>.freeze, ["~> 1.2"])
      s.add_dependency(%q<unicorn>.freeze, [">= 0.98"])
      s.add_dependency(%q<wrongdoc>.freeze, [">= 1.6.2", "~> 1.6.2"])
    end
  else
    s.add_dependency(%q<aggregate>.freeze, ["~> 0.2"])
    s.add_dependency(%q<io-extra>.freeze, [">= 1.2.3", "~> 1.2"])
    s.add_dependency(%q<posix_mq>.freeze, ["~> 2.0"])
    s.add_dependency(%q<rack>.freeze, ["~> 1.2"])
    s.add_dependency(%q<unicorn>.freeze, [">= 0.98"])
    s.add_dependency(%q<wrongdoc>.freeze, [">= 1.6.2", "~> 1.6.2"])
  end
end
