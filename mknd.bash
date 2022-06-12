#TODO script auto generation should come

#Colors#################################
GREEN='\033[0;32m'
NC='\033[0m'

FLAG_S=0
#option#################################
function usage_exit(){
    printf "Usage: $0 [-a] omits the script attachment."
    exit 1
}

while getopts ad:h OPT
do
    case $OPT in
        a) FLAG_S=1
           ;;
        h) usage_exit
           ;;
        \?) usage_exit
            ;;
    esac
done

#cache#################################
#Although I made this, this seems to be unneccesary.
function leave_cache(){
    arg=$1
    line=""
    cat test_cache.txt | awk -v "test=${arg}" '{print test==$1 ? "yes" : "no"}' | grep -q "yes"
    if [ $? -eq 0 ]; then
        about_to_insert=$(cat test_cache.txt | grep $arg| opy '[print(f"{F1} {F2+1}")]' | sed 's/None//g')
        sed '/'$arg' /d' test_cache.txt > tmp
        mv tmp test_cache.txt
        #test_cache.txt > test_cache.txt
        echo $about_to_insert >> test_cache.txt

    else
        echo $arg 0 >> test_cache.txt
    fi
}

#prompt
printf "\n${GREEN}    ┌─────────────────────────────┐\n┌───┤ ${GREEN}Enter the name of the scene │\n│   └─────────────────────────────┘\n└───> "
read NAME
NODE_DATA_BASE="/Users/yamamotoryuuji/tools/gd_sousa/test_node"

NODE_TYPE=$(cat $NODE_DATA_BASE| peco --prompt "NODE>")
leave_cache $NODE_TYPE

#FIXME the name DIR_PROJECT would not be appropriate.
DIR_PROJECT=$(ls | sed 's/\..*//g' | peco --prompt "SCRIPTS>")

if [ "$DIR_PROJRCT" = "" ];then
    #if the script is not existing in the current directory,
    #just create the script that extends from  Node class
    DIR_PROJECT="default"
    echo "extends Node" > default.gd
fi

#if there's no script, just add the one.
#there should be option to add it or not.
#So the condition statement sould

echo [gd_scene load_steps=2 format=2] > $NAME.tscn

printf "[ext_resource path=\"res://$DIR_PROJECT.gd\" type=\"Script\" id=1] \n" >> $NAME.tscn
#echo script = ExtResource\( 1 \) >> $NAME.tscn

#is id count from scratch in each directory?
#what if the child node increase in tscn?
echo  [node name=\"$NAME\" type=\"$NODE_TYPE\"] >> $NAME.tscn
echo script = ExtResource\( 1 \) >> $NAME.tscn

if [ $FLAG_S = 1 ]; then
    #delete the content once.
    cat $NAME.tscn | while read line; do echo $line | sed -e 's/\[ext.*//g' -e 's/script.*//g' ;done > tmp.txt
    cat tmp.txt > $NAME.tscn
    rm tmp.txt
fi

#TODO Actually the test_node data base is pretty unuseful
#I might need some wight for frequency, to make the peco interaction easier.
