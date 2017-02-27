#

name "makedepend"
default_version "1.0.5"

license "MIT"
license_file "COPYING"
skip_transitive_dependency_licensing true

source url: "https://www.x.org/releases/individual/util/makedepend-1.0.5.tar.gz",
       md5: "efb2d7c7e22840947863efaedc175747"

relative_path "makedepend-1.0.5"

dependency "xproto"
dependency "util-macros"
dependency "pkg-config-lite"

build do
  env = with_standard_compiler_flags(with_embedded_path)

  command "./configure --prefix=#{install_dir}/embedded", env: env

  make "-j #{workers}", env: env
  make "-j #{workers} install", env: env
end
