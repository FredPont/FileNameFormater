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

mutable struct Conf
    path::String
    maxFileChar::Int        # max number of characters in filename
    cutFileNames::Bool
    maxDirChar::Int         # max number of characters in directory
    cutDirNames::Bool
    terminalOutput::Bool    # print files/dir on the terminal
    rules::Any
    excludeDir::Any
    excludeDirByRegex::Bool # use regex instead of string to exclude directories
    excludeFiles::Any
end

include("src/installPKG.jl")
include("src/string_process.jl")
include("src/unit_test.jl")
include("src/list_files.jl")
include("src/rename.jl")
include("src/title.jl")
include("src/readConf.jl")

global config = readConf()    # software preferences

function main()
    # if the path is given as an argument, use it as the path to process
    if length(ARGS) > 0
    config.path = ARGS[1]
end
	title()
    #test()
    config.rules = readRegex()
    config.excludeDir = loadExcludeDirs()
    config.excludeFiles = loadExcludeFiles()
    t1 = time()

    prog = ProgressUnknown(
        desc = "Listing in progress:",
        spinner = true;
        enabled = !config.terminalOutput, # disable progress bar when terminalOutput
    )  # Create a progress meter
    list_files_Dir(config.path, prog)
    finish!(prog)  # Finish the progress meter

    t2 = time()
    println("Elapsed time : ", t2 - t1, " sec !")

    println("to rename the files, press y")
    input = readline(stdin)

    if input == "y"
        t2 = time()
        prog = ProgressUnknown(
            desc = "Renaming in progress:",
            spinner = true;
            enabled = !config.terminalOutput, # disable progress bar when terminalOutput
        )  # Create a progress meter
        rename_files_Dir(config.path, prog)
        finish!(prog)  # Finish the progress meter
    end
    t3 = time()
    println("Elapsed time : ", t3 - t2, " sec !")
end

main()
