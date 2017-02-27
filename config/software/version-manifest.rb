#

name "version-manifest"
description "generates a version manifest file"
default_version "0.0.1"

license :project_license
skip_transitive_dependency_licensing true

build do
  block do
    File.open("#{install_dir}/version-manifest.txt", "w") do |f|
      f.puts "#{project.name} #{project.build_version}"
      f.puts ""
      f.puts Omnibus::Reports.pretty_version_map(project)
    end
  end
end
