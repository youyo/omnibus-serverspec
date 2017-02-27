#

name "util-macros"
default_version "1.18.0"

version "1.19.0" do
  source md5: "40e1caa49a71a26e0aa68ddd00203717"
end

version "1.18.0" do
  source md5: "fd0ba21b3179703c071bbb4c3e5fb0f4"
end

source url: "https://www.x.org/releases/individual/util/util-macros-#{version}.tar.gz"

license "MIT"
license_file "COPYING"
skip_transitive_dependency_licensing true

relative_path "util-macros-#{version}"

build do
  env = with_standard_compiler_flags(with_embedded_path)

  command "./configure" \
          " --prefix=#{install_dir}/embedded", env: env

  make "-j #{workers}", env: env
  make "-j #{workers} install", env: env
end
