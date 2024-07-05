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

using DelimitedFiles
using JSON3

function readRegex()
    return readdlm("conf/rules.csv", '\t')
end

function readConf()
    # Read the JSON file into a string
    json_string = read("conf/conf.json", String)

    # Parse the JSON string into a Julia struct
    userConf = JSON3.read(json_string, Conf)

    return userConf
end