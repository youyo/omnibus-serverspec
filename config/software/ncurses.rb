#

name "ncurses"
default_version "5.9"

license "MIT"
license_file "http://invisible-island.net/ncurses/ncurses-license.html"
license_file "http://invisible-island.net/ncurses/ncurses.faq.html"
skip_transitive_dependency_licensing true

dependency "config_guess"

version("5.9") { source md5: "8cb9c412e5f2d96bc6f459aa8c6282a1", url: "https://ftp.gnu.org/gnu/ncurses/ncurses-5.9.tar.gz" }

relative_path "ncurses-#{version}"

build do
  env = with_standard_compiler_flags(with_embedded_path)
  env.delete("CPPFLAGS")

  update_config_guess

  if version == "5.9"
    # Patch to add support for GCC 5, doesn't break previous versions
    patch source: "ncurses-5.9-gcc-5.patch", plevel: 1, env: env
  end

  configure_command = [
    "./configure",
    "--prefix=#{install_dir}/embedded",
    "--enable-overwrite",
    "--with-shared",
    "--with-termlib",
    "--without-ada",
    "--without-cxx-binding",
    "--without-debug",
    "--without-manpages",
  ]

  command configure_command.join(" "), env: env
  make "-j #{workers}", env: env
  make "-j #{workers} install", env: env
  make "distclean", env: env
  configure_command << "--enable-widec"
  command configure_command.join(" "), env: env
  make "-j #{workers}", env: env
  make "-j #{workers} install", env: env
end
