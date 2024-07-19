# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# Written by Frederic PONT.
# (c) Frederic Pont 2024

# the advantage of package Continuables instead of walkdir is explained here :
# https://discourse.julialang.org/t/what-is-the-correct-way-to-ignore-some-files-directories-in-walkdir/26780/4
function rename_files_Dir(path::AbstractString, prog::ProgressUnknown)
	log = open("logfile.log", "a")
	list_all(path) = @cont begin
        next!(prog) # update progress bar
		if isfile(path)
			new_path = joinpath(dirname(path), stringProcess(basename(path), config))
			if path != new_path && !isfile(new_path) && isValidFile(basename(path))
				try
					mv(path, new_path)
					prettyPrint("file", path::AbstractString, new_path::AbstractString, :light_magenta, :yellow)
				catch err
					println(log, "@warn! $path → $new_path : $err")
				end
			end
			cont(new_path)
		elseif isdir(path)
			basename(path) in (config.excludeDir) && return    # skip directories in exclude list
			new_path = joinpath(
				dirname(path),
				stringProcess(basename(path), config; isFile = false),
			)
			if path != new_path && !isdir(new_path)
				try
					mv(path, new_path)
					prettyPrint("dir", path::AbstractString, new_path::AbstractString, :light_cyan, :light_red)
				catch err
					println(log, "@warn ! $path → $new_path : $err")
				end
			end

			for file in readdir(new_path)
				foreach(cont, list_all(joinpath(new_path, file)))
			end
		end
	end
	collect(list_all(path))
    close(log)
end
