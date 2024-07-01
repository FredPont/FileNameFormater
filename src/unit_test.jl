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

using Test



function test()
    @testset "clean_string test" begin
        str = "Hello, this is a string with spécial chàracters and spaces!"
        @test clean_string(str) ==
              "Hello_this_is_a_string_with_special_characters_and_spaces"
        @test clean_string("file.txt") == "file.txt"
        @test clean_string("file_1.txt") == "file_1.txt"
        @test clean_string("file-1.txt") == "file-1.txt"
        @test clean_string("file&1.txt") == "file1.txt"
    end

end