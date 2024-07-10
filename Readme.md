

#  File Name Formater
File Name Formater is a software to rename recursively files and folders.

# Features
- Rename files
- Rename directories
- unlimited number of regex patterns for renaming rules
- Truncate the file names
- Truncate the dir names
- Exclude some directories
- log file output

# Quick start
- install [Julia](https://julialang.org/downloads/)
- open a terminal
- go to the FileNameFormater directory using "cd" command
- to customise the characters replacement rules, edit the file ```conf/rules.csv ```(TAB seprator)
- to exclude some directories, edit the file ```conf/excludeDirList.csv ``` and enter one directory name (the name only, not the path) per line
- to enable file and/or dir names truncation, edit the file ```conf/conf.json```.




```
path = directory to analyse path
maxFileChar = maximum number of char in file names
cutFileNames : true/false enable/disable file names cutting
maxDirChar = maximum number of char in dir names
cutDirNames : true/false enable/disable dir names cutting
rules : do no edit, rules are loaded from the conf/rules.csv file, easier to edit for tabular data
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
julia main.jl 
```
CAUTION there is no recovery possible after file/dir names renaming or truncation.
You use this feature at your own risks.

# ScreenShots
![CLI](src/images/screenshot.png)
