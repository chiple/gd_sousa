#!/usr/bin/env bash

function leave_cache(){
    arg=$1
    line=""
    cat test_cache.txt | awk -v "test=${arg}" '{print test==$1 ? "yes" : "no"}' | grep -q "yes"
    if [ $? -eq 0 ]; then
        #TODO this way is not optimized just rewriting the whole contents of the cache.
        about_to_insert=$(cat test_cache.txt | grep $arg| opy '[print(f"{F1} {F2+1}")]' | sed 's/None//g')
        sed '/'$arg' /d' test_cache.txt > tmp
        mv tmp test_cache.txt
        #test_cache.txt > test_cache.txt
        echo $about_to_insert >> test_cache.txt

    else
        echo $arg 0 >> test_cache.txt
    fi
}
leave_cache nai
