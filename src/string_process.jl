
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

function stringProcess(str::AbstractString, config::Conf)
    cleanStr = clean_string(str)

end


function clean_string(str::AbstractString)
    rules = config.rules
    for i = 2:size(rules)[1] # :2 to skip first line
        str = replace(str, Regex(rules[i, 1]) => rules[i, 2])
    end
    return str
end


function cutString(str::AbstractString, maxCharNumber::Int)
    # get file extension if exists
    root, ext = splitext(str)
    if maxCharNumber < length(ext) + 3  # do not cut string under 3 char
        return str
    else
        return str[1:(maxCharNumber-length(ext))] * ext   # cut the string to maxCharNumber and substract the extension length
    end
end
