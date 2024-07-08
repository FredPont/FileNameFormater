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

mutable struct DirData
    oldDir::String
    oldPath::String
    newDir::String
    newPath::String
end

function rename_files_recursively(path)
    for (root, dirs, files) in walkdir(path)
        # Rename files
        for file in files
            old_path = joinpath(root, file)
            new_path = joinpath(root, clean_string(file))
            if old_path != new_path
                mv(old_path, new_path)
                println("Renamed file: $old_path -> $new_path")
            end
        end

    end
end


function rename_dir_recursively(path)
    dirList = listDirToRename(path)
    renameDirList(dirList)
end


function listDirToRename(path)::Array{DirData,1}
    newDirs = Array{DirData,1}()
    for (root, dirs, _) in walkdir(path)
        for d in dirs
            old_path = joinpath(root, d)
            new_dir = clean_string(d)
            new_path = joinpath(root, new_dir)
            if old_path != new_path
                push!(newDirs, DirData(d, old_path, new_dir, new_path))
            end
        end
    end
    return newDirs
end


function renameDirList(dirList::Array{DirData,1})
    for dirItem in reverse(dirList)	# reverse Array to start from the deepest dir to the highest
        try
            mv(dirItem.oldPath, dirItem.newPath)
            println("Renamed directory: ", dirItem.oldPath, "->", dirItem.newPath)
        catch err
            showerror(stdout, err)
        end
    end
end
