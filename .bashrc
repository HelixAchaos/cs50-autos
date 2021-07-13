# wah () { # just an example bc I forget stuff. Useful reference
#     ( for i in {1..3}; do
#     if [ 1==1 ]; then
#         exit -1 # 0: Found a match; -1,1,2: Didn't find a match
#     fi
# done ) && echo "Found a match" || echo "Didn't find a match"
# }


# mkcd [file_name] (-py|-c) (-m|-l) (-wget?)
mkcd () {
    local cwd=$PWD
    local file_name=$1
    folder_name=$1
    local comfort_version=$(
        case "$@" in
            *"-m"*) echo "more" ;;
            *"-l"*) echo "less" ;;
            *) echo "" ;;
        esac
    )
    folder_name=$file_name$comfort_version
    # pset_problem_name wget?
    # mkdir "ps"+$1 // was going to do: p_number, p_prob_name, wget?
    if [[ $@ == *"-wget"* ]]; then
        echo "wget"
        declare -a urls_list=()
        (for i in {3..9}; do
            local url="https://cdn.cs50.net/2020/fall/psets/$i/$file_name/$comfort_version/$file_name.zip"
            urls_list+=($url)
            echo $url
            wget $url
            if [[ $? == 0 ]]; then
                unzip "$file_name.zip"
                rm -f "$file_name.zip"
                # cd $file_name # cd $file_name # cd with subprocess won't change shown terminal
                mv $file_name $folder_name
                exit 0
            fi
        done; exit 1
        ) || (for i in {3..9}; do
            local url="https://cdn.cs50.net/2020/fall/psets/$i/$file_name/$file_name.c"
            urls_list+=($url)
            wget $url
            if [[ $? -eq 0 ]]; then
                mkdir $file_name
                mv "$file_name.c" "$file_name/$file_name.c"
                # cd $file_name # cd with subprocess won't change shown terminal
                exit 0
            fi
        done; exit 1) || (for i in {3..9}; do
            local url="https://cdn.cs50.net/2020/fall/psets/$i/$file_name/$file_name.zip" # "https://cdn.cs50.net/2020/fall/psets/$i/$file_name/$file_name.zip"
            urls_list+=($url)
            echo $url
            wget $url
            if [[ $? == 0 ]]; then
                unzip "$file_name.zip"
                rm -f "$file_name.zip"
                # cd $file_name # cd $file_name # cd with subprocess won't change shown terminal
                exit 0
            fi
        done; exit 1) && echo $folder_name && cd $folder_name || echo "Heh, something shid up. Can't find the pset."
        echo "before -> $file_name"
        local file_name+=$(case "$@" in
            *"-c"*)
                echo ".c"  ;;
            *"-py"*)
                echo ".py"  ;;
            *)
                echo ""  ;;
        esac)
        # would like a bfs (maybe https://stackoverflow.com/a/23948137), but i doubt any wget folder would have multiple files of the same filename
        echo $file_name
        (for i in $(find . -name $file_name); do
            echo $i
            open $i
            break
            exit 1
        done) && (case "$@" in
            *"-c"*)
                echo -e "#include <cs50.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <math.h>

int main(int argc, string argv[])
{

}"      > $file_name;
                open $file_name
            ;;
            *"-py"*)
                echo -e "# This is a sample Python script.

def welcome():
    print('CS50!')

if __name__ == '__main__':
    welcome()" > $file_name;
                open $file_name
            ;;
            *)
                echo "Specify Type!"
                return 1
            ;;
        esac) # used || bc if find is empty, that subprocess be True (exit 0 basically).
        # insert here
    else
        mkdir $folder_name
        cd $folder_name
        case "$@" in
            *"-c"*)
                echo -e "#include <cs50.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <math.h>

int main(int argc, string argv[])
{

}"      > $file_name.c;
                open $file_name.c
            ;;
            *"-py"*)
                echo -e "# This is a sample Python script.

def welcome():
    print('CS50!')

if __name__ == '__main__':
    welcome()" > $file_name.py;
                open $file_name.py
            ;;
            *)
                echo "Specify Type!"
                return 1
            ;;
        esac
    fi
    # unset i, file_name
}

# check51 [file_name] (-py|-c) (-m|-l)? (-g?)
check51 () {
    local cwd=$PWD
    if [[ "$@" == *"-g"* ]]; then
        cd
    fi
    # may need to be updated seasonly
    local path=cs50/problems/2021/summer/

    # look into unpacking tuples: https://stackoverflow.com/a/1952480 & https://stackoverflow.com/a/21625045
    # look into having file extensions added outside a swith-case. if there are many types, it'd get cluttered.->local file_name=$1.matched_arg[1:] # [1:] bc of - before arg
    case "$@" in
        *"-c"*)
            local path+=$1
            local file_name=$1.c
        ;;
        *"-py"*)
            local path+=sentimental/$1
            local file_name=$1.py
        ;;
        *)
            echo "Specify Type!"
            return 1
        ;;
    esac
    local comfort_version=$(
        case "$@" in
            *"-m"*) echo "more" ;;
            *"-l"*) echo "less" ;;
            *) echo "" ;;
        esac
    )
    if [[ $comfort_version != "" ]]; then
        path+=/$comfort_version
    fi
    for i in $(find . -name $file_name); do
        parent_dir="$(dirname -- "$i")"
        if [[ $parent_dir != "." && $parent_dir != *"$comfort_version"* ]]; then # if the file is in $cwd
            continue
        fi
        echo "cd $parent_dir"
        cd $parent_dir
        echo "check50 $path"
        check50 $path
        break
    done
    echo $cwd
    cd $cwd
}
