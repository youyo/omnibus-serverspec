#

name "serverspec"

dependency "ruby"
dependency "rubygems"

build do
  gem "install #{name} -v '2.38.0' -n #{install_dir}/bin --no-rdoc --no-ri"
end
