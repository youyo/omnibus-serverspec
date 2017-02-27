#

name "libiconv"
default_version "1.14"

license "LGPL-2.1"
license_file "COPYING.LIB"
skip_transitive_dependency_licensing true

dependency "config_guess"

source url: "https://ftp.gnu.org/pub/gnu/libiconv/libiconv-#{version}.tar.gz",
       md5: "e34509b1623cec449dfeb73d7ce9c6c6"

relative_path "libiconv-#{version}"

build do
  env = with_standard_compiler_flags(with_embedded_path)
  update_config_guess(target: "build-aux")
  update_config_guess(target: "libcharset/build-aux")
  patch source: "libiconv-1.14_srclib_stdio.in.h-remove-gets-declarations.patch", env: env
  configure(env: env)
  pmake = "-j #{workers}"
  make "#{pmake}", env: env
  make "#{pmake} install-lib" \
          " libdir=#{install_dir}/embedded/lib" \
          " includedir=#{install_dir}/embedded/include", env: env
end
