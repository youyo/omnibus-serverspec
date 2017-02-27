#

name "xproto"
default_version "7.0.25"

version "7.0.28" do
  source md5: "0b42843b99aee3e4f6a9cc7710143f86"
end

version "7.0.25" do
  source md5: "a47db46cb117805bd6947aa5928a7436"
end

source url: "https://www.x.org/releases/individual/proto/xproto-#{version}.tar.gz"

license "MIT"
license_file "COPYING"
skip_transitive_dependency_licensing true

relative_path "xproto-#{version}"

build do
  env = with_standard_compiler_flags(with_embedded_path)

  command "./configure" \
          " --prefix=#{install_dir}/embedded", env: env

  make "-j #{workers}", env: env
  make "-j #{workers} install", env: env
end
