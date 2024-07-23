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

function list_files_Dir(path::AbstractString, prog::ProgressUnknown)
    log = open("logfile.log", "w")
    list_all(path) = @cont begin
        next!(prog) # update progress bar
        if isfile(path)
            new_path = joinpath(dirname(path), stringProcess(basename(path), config))
            if path != new_path && isValidFile(basename(path))
                logAndTermOutput(log, "file", path, new_path, :light_magenta, :yellow)
            end
            cont(path)
        elseif isdir(path)
            new_path = joinpath(
                dirname(path),
                stringProcess(basename(path), config; isFile = false),
            )
            if path != new_path
                logAndTermOutput(log, "dir", path, new_path, :light_cyan, :light_red)
            end
            basename(path) in (config.excludeDir) && return    # skip directories in exclude list
            for file in readdir(path)
                foreach(cont, list_all(joinpath(path, file)))
            end
        end
    end

    collect(list_all(path))
    close(log)
    println("\nSee log file for details")
end


function prettyPrint(
    title::AbstractString,
    path::AbstractString,
    new_path::AbstractString,
    color1,
    color2,
)
    if config.terminalOutput
        print("$title: ")
        printstyled("$path", color = color1)
        printstyled(" → $new_path\n", color = color2)
    end
end

# logAndTermOutput list the path modifications on the terminal and in the log file
function logAndTermOutput(
    log,
    title::AbstractString,
    path::AbstractString,
    new_path::AbstractString,
    color1,
    color2,
)
    prettyPrint(
        title::AbstractString,
        path::AbstractString,
        new_path::AbstractString,
        color1,
        color2,
    )
    println(log, "$path → $new_path")
end
