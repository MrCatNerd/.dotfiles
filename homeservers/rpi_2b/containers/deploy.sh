#!/bin/env bash

# separate dependencies by whitespace
dep_list="pihole"

current_pwd="$PWD"

for docker_thingy in $dep_list
do
    if [[ -d $docker_thingy ]]; then
        cd "$docker_thingy" || exit 1

        if ! docker compose up -d; then
            echo "Failed to start $docker_thingy."
            exit 1
        fi

        cd "$current_pwd" || exit 1
    else
        echo "Directory $docker_thingy does not exist."
    fi
done

