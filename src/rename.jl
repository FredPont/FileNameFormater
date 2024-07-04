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
    for (root, dirs, files) in walkdir(path)
        for d in dirs
            old_path = joinpath(path, d)
            new_path = joinpath(path, clean_string(d))
            if old_path != new_path
                println("old_path : $old_path -> $new_path")
                try
                    mv(old_path, new_path)
                    rename_dir_recursively(new_path)
                catch
                    @warn "$new_path not converted"
                end
                println("Renamed directory: $old_path -> $new_path")
            end
        end
    end
end
