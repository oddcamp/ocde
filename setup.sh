#!/usr/bin/env sh

current_user=$(whoami)
github_access_token=$1

cat << EOF
#######  #####  ######  ####### 
#     # #     # #     # #       
#     # #       #     # #       
#     # #       #     # #####   
#     # #       #     # #       
#     # #     # #     # #       
#######  #####  ######  ####### 
EOF

echo
echo

echo "# We are about to create an image named \"ocde\" with"
echo "* GITHUB_ACCESS_TOKEN set as \"$github_access_token\""
echo "* Volume \"ocde_asdf\""
#echo "* Volume \"ocde_node_modules\""
echo

read -p " Should we proceed (y/n)?" choice

if [[ $choice =~ ^[Yy]$ ]]
then
    echo

    echo "## Building the image..\n"
    docker build --no-cache --rm --tag=ocde --build-arg GITHUB_ACCESS_TOKEN=$github_access_token .

    echo "## Creating the volumes..\n"
    docker volume create ocde_asdf
    #docker volume create ocde_node_modules

    echo "## Check \"README\" for more info"

    echo "## Done!"
fi

