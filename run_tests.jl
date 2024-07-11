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
    maxFileChar::Int  # max number of characters in filename
    cutFileNames::Bool
    maxDirChar::Int  # max number of characters in directory
    cutDirNames::Bool
    rules::Any
    exclude::Any
end


include("src/installPKG.jl")
include("src/string_process.jl")
include("src/unit_test.jl")
include("src/readConf.jl")

global config = readConf()    # software preferences
config.rules = readRegex()

test()