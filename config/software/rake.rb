#

name "rake"

dependency "ruby"
dependency "rubygems"

build do
  gem "install #{name} -v '12.0.0' -n #{install_dir}/bin --no-rdoc --no-ri"
end
