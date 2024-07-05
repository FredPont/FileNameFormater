

#  File Name Formater
File Name Formater is a software to rename recursively files and folders, removing spaces and special characters.


# Quick start
- install [Julia](https://julialang.org/downloads/)
- open a terminal
- to customise the characters replacement rules, edit the file conf/rules.csv (TAB seprator)
- to enable file and/or dir names truncation, edit the file conf/conf.json

```
path = directory to analyse path
maxFileChar = maximum number of char in file names
cutFileNames : true/false enable/disable file names cutting
maxDirChar = maximum number of char in dir names
cutDirNames : true/false enable/disable dir names cutting
```

```
{
    "path":"test",
    "maxFileChar": 30,
    "cutFileNames": true,
    "maxDirChar": 30,
    "cutDirNames": true,
    "rules": []
}

```

- start the software using the syntax :

```
julia main_recursive.jl path/   

# example to analyse the test directory
julia main_recursive.jl test/   

```

# ScreenShots
![CLI](src/images/screenshot.png)
