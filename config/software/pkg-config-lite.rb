#

name "pkg-config-lite"
default_version "0.28-1"

license "GPL-2.0"
license_file "COPYING"
skip_transitive_dependency_licensing true

dependency "config_guess"

version "0.28-1" do
  source md5: "61f05feb6bab0a6bbfab4b6e3b2f44b6"
end

source url: "http://downloads.sourceforge.net/project/pkgconfiglite/#{version}/pkg-config-lite-#{version}.tar.gz"

relative_path "pkg-config-lite-#{version}"

build do
  env = with_standard_compiler_flags(with_embedded_path)

  update_config_guess

  command "./configure" \
          " --prefix=#{install_dir}/embedded" \
          " --disable-host-tool" \
          " --with-pc-path=#{install_dir}/embedded/bin/pkgconfig", env: env

  make "-j #{workers}", env: env
  make "-j #{workers} install", env: env
end
