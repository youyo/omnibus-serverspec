#

name "libtool"
default_version "2.4"

license "GPL-2.0"
license_file "COPYING"
skip_transitive_dependency_licensing true

dependency "config_guess"

version("2.4.6") { source md5: "addf44b646ddb4e3919805aa88fa7c5e" }
version("2.4.2") { source md5: "d2f3b7d4627e69e13514a40e72a24d50" }
version("2.4")   { source md5: "b32b04148ecdd7344abc6fe8bd1bb021" }

source url: "https://ftp.gnu.org/gnu/libtool/libtool-#{version}.tar.gz"

relative_path "libtool-#{version}"

build do
  env = with_standard_compiler_flags(with_embedded_path)

  update_config_guess
  update_config_guess(target: "libltdl/config")

  command "./configure" \
          " --prefix=#{install_dir}/embedded", env: env

  make env: env
  make "install", env: env
end
