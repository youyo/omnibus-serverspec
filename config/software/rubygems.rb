#

name "rubygems"

license "MIT"
license_file "https://raw.githubusercontent.com/rubygems/rubygems/master/LICENSE.txt"
skip_transitive_dependency_licensing true

dependency "ruby"

if version && !source
  known_tarballs = {
    "2.1.11" => "b561b7aaa70d387e230688066e46e448",
    "2.2.1" => "1f0017af0ad3d3ed52665132f80e7443",
    "2.4.1" => "7e39c31806bbf9268296d03bd97ce718",
    "2.4.4" => "440a89ad6a3b1b7a69b034233cc4658e",
    "2.4.5" => "5918319a439c33ac75fbbad7fd60749d",
    "2.4.8" => "dc77b51449dffe5b31776bff826bf559",
    "2.6.7" => "9cd4c5bdc70b525dfacd96e471a64605",
    "2.6.8" => "40b3250f28c1d0d5cb9ff5ab2b17df6e",
  }
  known_tarballs.each do |version, md5|
    self.version version do
      source md5: md5, url: "http://production.cf.rubygems.org/rubygems/rubygems-#{version}.tgz"
      relative_path "rubygems-#{version}"
    end
  end

  version("v2.4.4_plus_debug") { source git: "https://github.com/danielsdeleo/rubygems.git" }
  version("2.4.4.debug.1")     { source git: "https://github.com/danielsdeleo/rubygems.git" }
  version("jdm/2.4.8-patched") { source git: "https://github.com/jaym/rubygems.git" }
end

if version && !source
  begin
    Gem::Version.new(version)
  rescue ArgumentError
    source git: "https://github.com/rubygems/rubygems.git"
  end
end

if source && source.include?(:git)
  relative_path "rubygems"
end

build do
  env = with_standard_compiler_flags(with_embedded_path)

  if source
    ruby "setup.rb --no-ri --no-rdoc", env: env
  else
    gem "update --no-document --system #{version}", env: env
  end
end
