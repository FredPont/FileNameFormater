using Test
using FilePathsBase


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

function clean_string(str::AbstractString)
    # The regular expression r"[^\w\s.\-_]" matches any whitespace characters \s 
    # and any non-word characters \w, dot, - and _
    str = replace(str, r"[^\w\s.\-_]" => "")
    str = replace(str, r"[\s]+" => "_")
    str = replace(str, r"[à]+" => "a")
    str = replace(str, r"[éèêë]+" => "e")
    return str
end



function list_files_dirs_recursively(path)
    list_files_recursively(path)
    list_dir_recursively(path)
end

function list_files_recursively(path)
    for (root, dirs, files) in walkdir(path)
        # Rename files
        for file in files
            old_path = joinpath(root, file)
            new_path = joinpath(root, clean_string(file))
            if old_path != new_path
                println("Rename file: $old_path -> $new_path")
            end
        end

    end
end

function list_dir_recursively(path)
    dirs = readdir(path)
    for d in dirs
        old_path = joinpath(path, d)
        new_path = joinpath(path, clean_string(d))
        if old_path != new_path
            println("Rename dir : $old_path -> $new_path")
        end
    end
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
    dirs = readdir(path)
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

function main()
    test()
    if length(ARGS) < 1
        println("dir name is missing as argument. ex : julia main.jl test/")
        return
    end
    dir = ARGS[1]

    list_files_dirs_recursively(dir)

    println("to rename the files, press y")
    input = readline(stdin)

    if input == "y"
        rename_files_recursively(dir)
        rename_dir_recursively(dir)
    end


end

main()
