# wah () { # just an example bc I forget stuff. Useful reference
#     ( for i in {1..3}; do
#     if [ 1==1 ]; then
#         exit -1 # 0: Found a match; -1,1,2: Didn't find a match
#     fi
# done ) && echo "Found a match" || echo "Didn't find a match"
# }


# mkcd (-py|-c) (-m|-l) (-wget?)
mkcd () {
    local cwd=$PWD
    local file_name=$1
    folder_name=$1
    local comfort_version=""
    if [[ $# > 2 ]]; then
        if [[ $3 == "-m" ]]; then
            comfort_version="more"
        else comfort_version="less"
        fi
    fi
    folder_name=$file_name$comfort_version
    # pset_problem_name wget?
    # mkdir "ps"+$1 // was going to do: p_number, p_prob_name, wget?
    if [[ $# > 3 && $4 == "-wget" ]]; then
        declare -a urls_list=()
        (for i in {3..9}; do
            url="https://cdn.cs50.net/2020/fall/psets/$i/$file_name/$comfort_version/$file_name.zip"
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
            url="https://cdn.cs50.net/2020/fall/psets/$i/$file_name/$file_name.c"
            urls_list+=($url)
            wget $url
            if [[ $? -eq 0 ]]; then
                mkdir $file_name
                mv "$file_name.c" "$file_name/$file_name.c"
                # cd $file_name # cd with subprocess won't change shown terminal
                exit 0
            fi
        done; exit 1) || (for i in {3..9}; do
            url="https://cdn.cs50.net/2020/fall/psets/$i/$file_name/$file_name.zip"
            urls_list+=($url)
            echo $url
            wget $url
            if [[ $? == 0 ]]; then
                unzip "$file_name.zip"
                rm -f "$file_name.zip"
                # cd $file_name # cd $file_name # cd with subprocess won't change shown terminal
                exit 0
            fi
        done; exit 1) && echo $folder_name && cd $folder_name && open $file_name.c || echo "Heh, something shid up. Can't find the pset."

        # insert here
    else
        mkdir $folder_name
        cd $folder_name
        if [[ $2 == "-c" ]]; then
            echo -e "#include <cs50.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <math.h>

int main(int argc, string argv[])
{

}"      > $file_name.c;
        open $file_name.c
        else
            echo -e "" > $file_name.py;
            open $file_name.py
        fi
    fi
    # unset i, file_name
}

# check51 (file_name) (-py|-c) (-m|{-l?})
check51 () {
    local cwd=$PWD
    cd
    local comfort_version=""
    if [[ $2 == "-c" ]]; then
        local path=cs50/problems/2021/summer/$1
        local filename=$1.c
        echo $2
    else
        local path=cs50/problems/2021/summer/sentimental/$1
        local filename=$1.py
    fi
    if [[ $# > 2 ]]; then
        if [[ $3 == "-m" ]] ; then
            comfort_version="more"
        else comfort_version="less"
        fi
        path+="/$comfort_version"
    fi
    for i in $(find . -name $filename); do
        parent_dir="$(dirname -- "$i")"
        if [[ $parent_dir != *"$comfort_version"* ]]; then
            continue
        fi
        echo $parent_dir
        echo "cd $parent_dir"
        cd $parent_dir
        echo "check50 $path"
        check50 $path
        break
    done
    echo $cwd
    cd $cwd
}
