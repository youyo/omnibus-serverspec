#

name "openssl"

license "OpenSSL"
license_file "LICENSE"
skip_transitive_dependency_licensing true

dependency "zlib"
dependency "cacerts"
dependency "makedepend"

default_version "1.0.2j"

source url: "https://www.openssl.org/source/openssl-#{version}.tar.gz", extract: :lax_tar

version("1.0.2j") { source sha256: "e7aff292be21c259c6af26469c7a9b3ba26e9abaaffd325e3dccc9785256c431" }
version("1.0.2i") { source sha256: "9287487d11c9545b6efb287cdb70535d4e9b284dd10d51441d9b9963d000de6f" }
version("1.0.2h") { source sha256: "1d4007e53aad94a5b2002fe045ee7bb0b3d98f1a47f8b2bc851dcd1c74332919" }
version("1.0.2g") { source md5: "f3c710c045cdee5fd114feb69feba7aa" }
version("1.0.1u") { source sha256: "4312b4ca1215b6f2c97007503d80db80d5157f76f8f7d3febbe6b4c56ff26739" }
version("1.0.1t") { source md5: "9837746fcf8a6727d46d22ca35953da1" }
version("1.0.1s") { source md5: "562986f6937aabc7c11a6d376d8a0d26" }
version("1.0.1r") { source md5: "1abd905e079542ccae948af37e393d28" }

relative_path "openssl-#{version}"

build do
  env = with_standard_compiler_flags(with_embedded_path)
  configure_args = [
    "--prefix=#{install_dir}/embedded",
    "--with-zlib-lib=#{install_dir}/embedded/lib",
    "--with-zlib-include=#{install_dir}/embedded/include",
    "no-idea",
    "no-mdc2",
    "no-rc5",
    "shared",
		"zlib"
  ]

  configure_cmd = "./config disable-gost"
  patch source: "openssl-1.0.1f-do-not-build-docs.patch", env: env
  configure_args << env["CFLAGS"] << env["LDFLAGS"]
  configure_command = configure_args.unshift(configure_cmd).join(" ")
  command configure_command, env: env, in_msys_bash: true
  make "depend", env: env
  make env: env
  make "install", env: env
end
