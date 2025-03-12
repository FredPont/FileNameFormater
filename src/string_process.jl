
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

function stringProcess(
    str::AbstractString,
    config::Conf;
    isFile::Bool = true,
)::AbstractString
    cleanStr = clean_string(str)
    if isFile && config.cutFileNames
        return cutString(cleanStr, config.maxFileChar)
    elseif !isFile && config.cutDirNames
        return cutString(cleanStr, config.maxDirChar)
    else
        return cleanStr
    end
end

# clean_string remove special char and rename string according to the config.rules list of user regex
function clean_string(str::AbstractString)::AbstractString
    rules = config.rules
    for i ∈ 2:size(rules)[1] # :2 to skip first line
        str = replace(str, Regex(rules[i, 1]) => rules[i, 2])
    end
    return str
end


function cutString(str::AbstractString, maxCharNumber::Int)::AbstractString
    # get file extension if exists
    _, ext = splitext(str)

    if length(str) > maxCharNumber && length(ext) < maxCharNumber
        return substring(str, 1, maxCharNumber - length(ext)) * ext   # cut the string to maxCharNumber and substract the extension length
    end
    return str
end

# isValidFile return true if the filename do not match exclude file list (using regex)
function isValidFile(filename::AbstractString)::Bool
    rules = config.excludeFiles
    for reg ∈ rules
        if occursin(Regex(reg), filename)
            return false
        end
    end
    return true
end

# isValidDir return true if the direname do not match exclude dir list (using regex)
function isValidDir(direname::AbstractString)::Bool
    rules = config.excludeDirs
    for reg ∈ rules
        if occursin(Regex(reg), dirname)
            return false
        end
    end
    return true
end

# stubstring substitution of julia SubString function that produce an error with special char such as "â"
# SubString("mâles", 1, 3)
# ERROR: StringIndexError: invalid index [3], valid nearby indices [2]=>'â', [4]=>'l'
# substring("mâles", 1, 3)
# "mâl"
# https://discourse.julialang.org/t/substring-function/76675/8
substring(str, start, stop) = view(str, nextind(str, 0, start):nextind(str, 0, stop))