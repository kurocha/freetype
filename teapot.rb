
#
#  This file is part of the "Teapot" project, and is released under the MIT license.
#

required_version "0.5"

define_target "freetype" do |target|
	target.install do |environment|
		environment.use in: (package.path + "freetype-2.4.10") do |config|
			Commands.run!("make", "distclean") if File.exist? "Makefile"
			Commands.run!("rm", "-f", "config.mk")
			
			Commands.run("./configure",
				"--prefix=#{config.install_prefix}",
				"--enable-shared=no",
				"--enable-static=yes", 
				*config.configure
			)
			
			Commands.run("make", "install")
		end
	end
	
	target.depends(:platform)
	
	target.provides 'freetype' do
		append buildflags {"-I" + (install_prefix + "include/freetype2").to_s}
		append ldflags "-lfreetype"
	end
end
