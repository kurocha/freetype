
#
#  This file is part of the "Teapot" project, and is released under the MIT license.
#

required_version "0.1"

define_package "freetype-2.4.10" do |package|
	package.build(:all) do |platform, environment|
		environment.use in: package.source_path do |config|
			Commands.run("make", "distclean") if File.exist? "Makefile"
			
			Commands.run('rm', '-f', 'config.mk')
			
			Commands.run("./configure",
				"--prefix=#{platform.prefix}",
				"--enable-shared=no",
				"--enable-static=yes", 
				*config.configure
			)
			
			Commands.run("make install")
		end
		
		Commands.run("cp", "FindFreeType.cmake", platform.cmake_modules_path)
	end
end
