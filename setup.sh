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
echo "* Volume \"ocde\""
echo

read -p " Should we proceed (y/n)?" choice

if [[ $choice =~ ^[Yy]$ ]]
then
    echo

    echo "## Building the image..\n"
    docker build --no-cache --rm --tag=ocde --build-arg GITHUB_ACCESS_TOKEN=$github_access_token .

    echo "## Creating the volume..\n"
    docker volume create ocde

    echo "## Done!"
fi

