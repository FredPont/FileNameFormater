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

using FilePathsBase

function list_files_Dir(path)
    log = open("logfile.log", "w")
    list_all(path) = @cont begin
        if isfile(path)
            new_path = joinpath(dirname(path), stringProcess(basename(path), config))
            if path != new_path
                println("Rename file: $path -> $new_path")
                println(log, "$path -> $new_path")
            end
            cont(path)
            #endswith(path, ".ext") && cont(path)
        elseif isdir(path)
            new_path = joinpath(
                dirname(path),
                stringProcess(basename(path), config; isFile = false),
            )
            if path != new_path
                println("Rename dir: $path-> $new_path")
                println(log, "$path -> $new_path")
            end
            basename(path) in (config.exclude) && return
            for file in readdir(path)
                foreach(cont, list_all(joinpath(path, file)))
            end
        end
    end
    
    collect(list_all(path))
    close(log)
    println("See log file for details")
end
