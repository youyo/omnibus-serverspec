#

name "libyaml"
default_version "0.1.6"

license "MIT"
license_file "LICENSE"
skip_transitive_dependency_licensing true

dependency "config_guess"

source url: "http://pyyaml.org/download/libyaml/yaml-#{version}.tar.gz",
       md5: "5fe00cda18ca5daeb43762b80c38e06e"

relative_path "yaml-#{version}"

build do
  env = with_standard_compiler_flags(with_embedded_path)
  update_config_guess(target: "config")
  configure "--enable-shared", env: env
  make "-j #{workers}", env: env
  make "-j #{workers} install", env: env
end
