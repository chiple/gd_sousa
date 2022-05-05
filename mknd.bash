#TODO script auto generation should come
GREEN='\033[0;32m'
NC='\033[0m'
printf "\n${GREEN}    ┌─────────────────────────────┐\n┌───┤ ${GREEN}Enter the name of the scene │\n│   └─────────────────────────────┘\n└───> "
read NAME
NODE_DATA_BASE="/home/ryu/tools/gd-cli/test_node"

NODE_TYPE=$(cat $NODE_DATA_BASE| peco --prompt "NODE>")
DIR_PROJECT=$(ls | sed 's/\..*//g' | peco --prompt "SCRIPTS>")

echo [gd_scene load_steps=2 format=2] > $NAME.tscn

printf "[ext_resource path=\"res://$DIR_PROJECT.gd\" type=\"Script\" id=1] \n" >> $NAME.tscn
#is id count from scratch in each directory?
#what if the child node increase in tscn?
echo  [node name=\"$NAME\" type=\"$NODE_TYPE\"] >> $NAME.tscn
echo script = ExtResource\( 1 \) >> $NAME.tscn
