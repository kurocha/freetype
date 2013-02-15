
#
#  This file is part of the "Teapot" project, and is released under the MIT license.
#

required_version "0.6"

define_target "freetype" do |target|
	target.install do |environment|
		install_external(package.path, "freetype-2.4.10", environment) do |config, fresh|
			if fresh
				Commands.run("./configure",
					"--prefix=#{config.install_prefix}",
					"--enable-shared=no",
					"--enable-static=yes", 
					*config.configure
				)
			end
			
			Commands.make_install
		end
	end
	
	target.depends(:platform)
	target.depends "Library/bz2"
	target.depends "Library/z"
	
	target.provides 'Library/freetype' do
		append buildflags {"-I" + (install_prefix + "include/freetype2").to_s}
		append ldflags "-lfreetype"
	end
end
