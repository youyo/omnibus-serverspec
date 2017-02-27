#

name "omnibus-serverspec"
maintainer "youyo"
homepage "https://github.com/youyo/omnibus-serverspec"

install_dir "/opt/#{name}"

build_version '2.38.0'
build_iteration 1

dependency "preparation"
dependency "ruby"
dependency "rake"
dependency "serverspec"
dependency "version-manifest"

exclude "**/.git"
exclude "**/bundler/git"
