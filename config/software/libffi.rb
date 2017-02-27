#

name "libffi"

default_version "3.2.1"

license "MIT"
license_file "LICENSE"
skip_transitive_dependency_licensing true

dependency "libtool"

version("3.0.13") { source md5: "45f3b6dbc9ee7c7dfbbbc5feba571529" }
version("3.2.1")  { source md5: "83b89587607e3eb65c70d361f13bab43" }

source url: "ftp://sourceware.org/pub/libffi/libffi-#{version}.tar.gz"

relative_path "libffi-#{version}"

build do
  env = with_standard_compiler_flags(with_embedded_path)
  env["INSTALL"] = "/opt/freeware/bin/install" if aix?
  configure_command = []

  if version == "3.2.1"
    patch source: "libffi-3.2.1-disable-multi-os-directory.patch", plevel: 1, env: env
    configure_command << "--disable-multi-os-directory"
  end

  configure(*configure_command, env: env)
  make "-j #{workers}", env: env
  make "-j #{workers} install", env: env
  copy "#{install_dir}/embedded/lib/libffi-#{version}/include/*", "#{install_dir}/embedded/include"
end
