
#
#  This file is part of the "Teapot" project, and is released under the MIT license.
#

required_version "0.5"

define_package "freetype" do |package|
	package.install do |environment|
		environment.use in: package.source_path do |config|
			Commands.run("make", "distclean") if File.exist? "Makefile"
			
			Commands.run("rm", "-f", "config.mk")
			
			Commands.run("./configure",
				"--prefix=#{environment.install_prefix}",
				"--enable-shared=no",
				"--enable-static=yes", 
				*config.configure
			)
			
			Commands.run("make", "install")
		end
	end
	
	package.provides 'freetype' do
		append buildflags {"-I" + (install_prefix + "include/freetype2").to_s}
		append ldflags "-lfreetype"
	end
end
