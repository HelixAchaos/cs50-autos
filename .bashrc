# wah () { # just an example bc I forget stuff. Useful reference
#     ( for i in {1..3}; do
#     if [ 1==1 ]; then
#         exit -1 # 0: Found a match; -1,1,2: Didn't find a match
#     fi
# done ) && echo "Found a match" || echo "Didn't find a match"
# }


mkcd () {
    cwd=$PWD
    file_name=$1
    # pset_problem_name wget?
    # mkdir "ps"+$1 // was going to do: p_number, p_prob_name, wget?
    if [[ $# > 1 && $2 == "-wget" ]]; then
        declare -a urls_list=()
        (for i in {3..9}; do
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
        done; exit 1) && cd $file_name && (for file in $files; do open $file; done) || echo "Heh, something shid up. Can't find the pset."

        # insert here
    else
        mkdir $file_name
        echo $file_name
        cd $file_name
        echo -e "#include <cs50.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <math.h>

int main(int argc, string argv[])
{

}"      > $file_name.c
    open $file_name.c
    fi


    # unset i, file_name
}

check51 () {
    cwd=$PWD
    for i in $(find . -name "$1.c"); do
        parent_dir="$(dirname -- "$i")"
        echo "cd $parent_dir"
        cd $parent_dir
        check50 cs50/problems/2021/summer/$1
        break
    done
    cd cwd
}
