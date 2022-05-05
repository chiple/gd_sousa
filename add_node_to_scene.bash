#!/usr/bin/env bash
function countnodeid(){
    local IFS='('
    read -d '\)' IDS
}
# $some_array[-1] also attain the last element of array
# but some version of bash don't do that.
function last(){
    arr=("$@")
    for last in "${arr[@]}"
    do :
    done
    echo ${last}
}

function get_existing_node(){

    cat $1 | grep '\[node' ; printf "."
}

FILE_NAME=$(ls | grep '.tscn' | peco --prompt "NODE TO ADD>")
NODE_DATA_BASE="/home/ryu/tools/gd-cli/test_node"

linum_list=$(cat $FILE_NAME | while read line; do echo $line; done \
    | sed -E 's/.*\((.*)\)/\1/g' | sed -E 's/\[.*//g' | xargs | sort)

declare -a arr=($linum_list)
new_id=$(($(last "${arr[@]}") + 1))

#I don't know why I have to divide this.
PARENT_RAW=$(get_existing_node $FILE_NAME | peco --prompt "Parent>")
PARENT=$(echo $PARENT_RAW | sed -E 's/\[||\]//g' | sed -E 's/node name=(.*)type=\".*\"/\1/g')
echo $PARENT

NODE_TYPE=$(cat $NODE_DATA_BASE | peco --prompt "Type>")
printf "input the name of the node>> "
read NODE_NAME
printf "[node name=\"$NODE_NAME\" type=\"$NODE_TYPE\" parent=\"$(echo $PARENT)\"]">> $FILE_NAME

#TODO maybe I have to add the declareation of the the script path
#that should come at the top of the .tscn file
