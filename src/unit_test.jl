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
    println("Unit test")
    println(".................")
    @testset "clean_string test" begin
        str = "Hello, this is a string with spécial chàracters and spaces!"
        @test clean_string(str) ==
              "Hello_this_is_a_string_with_special_characters_and_spaces"
        @test clean_string("file.txt") == "file.txt"
        @test clean_string("file_1.txt") == "file_1.txt"
        @test clean_string("file-1.txt") == "file-1.txt"
        @test clean_string("file&1.txt") == "file1.txt"
    end

    @testset "Regex test" begin
        @test replace("Hello, this is a string with spécial chàracters and spaces!", r"[^\w\s.\-_]+" => "") == "Hello this is a string with spécial chàracters and spaces"
    end

    @testset "cut string test" begin
         @test cutString("textfilename.txt", 7) == "tex.txt"
        @test cutString("text.txt", 5) == "t.txt"
        @test cutString("textfilename", 5) == "textf"
        @test cutString("text.txt", 3) == "text.txt"
    end
    println("end test")
    println(".................")
end