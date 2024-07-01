using Test

function clean_string(str::AbstractString)
    # The regular expression r"[^\w\s.\-_]" matches any whitespace characters \s 
    # and any non-word characters \w, dot, - and _
    str = replace(str, r"[^\w\s.\-_]" => "")
    str = replace(str, r"[\s]+" => "_")
    str = replace(str, r"[à]+" => "a")
    str = replace(str, r"[éèêë]+" => "e")
    return str
end

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

function showFiles(files)
    for f in files
        newName = clean_string(f)
        if f != newName
            println(f, " => ", newName)
        end

    end
end

function renameFiles(dir, files)
    for f in files
        newName = clean_string(f)
        if f != newName
            println(f, " => ", newName)
            mv(dir * f, dir * newName)  # rename the file without special char
        end

    end
end

function main()
    test()
    if length(ARGS) < 1
        println("dir name is missing as argument. ex : julia main.jl test/")
        return
    end
    dir = ARGS[1]

    files = readdir(dir)
    showFiles(files)

    println("to rename the files, press y")
    input = readline(stdin)

    if input == "y"
        renameFiles(dir, files)
    end


end

main()
