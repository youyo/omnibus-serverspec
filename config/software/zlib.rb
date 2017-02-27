#

name "zlib"
default_version "1.2.8"

version "1.2.8" do
  source md5: "44d667c142d7cda120332623eab69f40"
end

source url: "http://downloads.sourceforge.net/project/libpng/zlib/#{version}/zlib-#{version}.tar.gz"

license "Zlib"
license_file "README"
skip_transitive_dependency_licensing true

relative_path "zlib-#{version}"

build do
	env = with_standard_compiler_flags
  configure env: env

  make "-j #{workers}", env: env
  make "-j #{workers} install", env: env
end
